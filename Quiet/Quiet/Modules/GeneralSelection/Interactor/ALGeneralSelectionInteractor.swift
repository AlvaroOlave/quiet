//
//  ALGeneralSelectionInteractor.swift
//  Quiet
//
//  Created by Alvaro on 26/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import Foundation

class ALGeneralSelectionInteractor: ALGeneralSelectionInteractorProtocol {
    var dataManager: ALGeneralSelectionDataManagerProtocol!
    var section: Section!
 
    func getResourcesList(completion: @escaping ([ALSectionElem]) -> Void) {
        dataManager.getResourcesListOf(section) {
            guard let response = $0 else { completion([]); return }
            completion(ALSectionElem.sectionElemsFrom(dict: response, of: self.section))
        }
    }
    
    func getCompleteInfoOf(_ elem: ALSectionElem, completion: @escaping (ALBaseElem) -> Void) {
        switch elem.kindOfResource {
        case .SleepCast:
            getSleepCastInfo(from: elem, completion: completion)
        case .Landscapes:
            getLandscapeInfo(from: elem, completion: completion)
        default:
            getGeneralInfo(from: elem, completion: completion)
        }
        
    }
    
    private func getSleepCastInfo(from elem: ALSectionElem, completion: @escaping (ALSleepCastElem) -> Void) {
        
        var primary: Data?
        var secondary: Data?
        
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .userInitiated)
        
        queue.async(group : group) {
            group.enter()
            self.dataManager.getResource((elem.resourceURL as! (String, String)).0) { (data) in
                primary = data
                group.leave()
            }
            group.enter()
            self.dataManager.getResource((elem.resourceURL as! (String, String)).1) { (data) in
                secondary = data
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.main) {
            completion(ALSleepCastElem(baseSection: elem, primarySound: primary, secondarySound: secondary))
        }
    }
    
    private func getLandscapeInfo(from elem: ALSectionElem, completion: @escaping (ALLandscapeElem) -> Void) {
        var images = [Data]()
        var sound: Data?
        
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .userInitiated)
        
        queue.async(group : group) {
            var imageURLs = elem.resourceURL as! [String]
            let soundURL = imageURLs.removeLast()
            imageURLs.forEach({ url in
                group.enter()
                self.dataManager.getResource(url) {
                    if let data = $0 { images.append(data) }
                    group.leave()
                }
            })
            group.enter()
            self.dataManager.getResource(soundURL) { (data) in
                sound = data
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.main) {
            completion(ALLandscapeElem(baseSection: elem, images: images, sound: sound))
        }
    }
    
    private func getGeneralInfo(from elem: ALSectionElem, completion: @escaping (ALGeneralElem) -> Void) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.dataManager.getResource(elem.resourceURL as! String) { data in
                DispatchQueue.main.async { completion(ALGeneralElem(baseSection: elem, resource: data)) }
            }
        }
    }
    
    
    func dismiss() { dataManager.dismiss() }
}
