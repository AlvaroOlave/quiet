//
//  ALBaseDataManager.swift
//  Quiet
//
//  Created by Alvaro on 16/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class ALRealtimeClient {
    
    let databaseReference : Database = Database.database()
    
    let completionBlock: (DataSnapshot, (([Any]?) -> Void)) -> Void = { snapshot, success in
        guard snapshot.exists() else { success(nil); return }
        
        success(snapshot.children.compactMap({ item -> [AnyHashable : Any]? in
            return (item as! DataSnapshot).value as? [AnyHashable : Any] ?? nil
        }))
    }
    
    func GET(URLString : String!,
             success : @escaping ([Any]?) -> Void) -> (() -> Void)? {
        
        let childReference = databaseReference.reference(withPath: URLString)
        
        childReference.keepSynced(true)
        
        let completionFirebase : (DataSnapshot) -> (Void) = { self.completionBlock($0, success) }
        
        let observerHandleValue: UInt? = childReference.queryOrderedByKey().observe(.value, with: completionFirebase)
        
        guard let value = observerHandleValue else { return nil }
        return { self.databaseReference.reference(withPath: URLString).removeObserver(withHandle: value) }
    }
}

class ALStorageClient {
    func downloadImage(ref: String, completion: @escaping (UIImage?) -> Void){
        downloadFile(fileName: ref) {
            guard let data = $0 else { completion(nil); return }
            completion(UIImage(data: data))
        }
    }
    
    func downloadFile(fileName: String, completion: @escaping (Data?) -> Void) {
        let storageReference = Storage.storage().reference().child(fileName)
        storageReference.getMetadata { [weak self] metadata, error in
            guard error == nil else { completion(nil); return }
            //Get Local file created date
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let filePath = paths[0] + fileName
            if FileManager.default.fileExists(atPath: filePath) {
                do{
                    let attrs = try FileManager.default.attributesOfItem(atPath: filePath) as NSDictionary
                    
                    if((metadata?.updated!)! > attrs.fileCreationDate()!){
                        self?.downloadFile(storageReference, fileName: fileName, completion: completion)
                    } else {
                        completion(self?.dataFromURL(URL(string: filePath)))
                    }
                }
                catch {
                    completion(nil)
                }
            } else {
                self?.downloadFile(storageReference, fileName: fileName, completion: completion)
            }
        }
    }
    
    private func downloadFile(_ reference: StorageReference, fileName: String, completion: @escaping (Data?) -> Void) {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let filePath = paths[0] + fileName
        let fileURL = URL.init(string: filePath)
        
        reference.write(toFile: fileURL!, completion: { (url, error) in
            guard error == nil else { return }
            
            completion(self.dataFromURL(URL(string: filePath)))
        })
    }
    
    private func dataFromURL(_ url: URL?) -> Data? {
        guard let url = url else { return nil }
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                return nil
            }
    }
}
