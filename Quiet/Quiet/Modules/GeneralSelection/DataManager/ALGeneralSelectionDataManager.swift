//
//  ALGeneralSelectionDataManager.swift
//  Quiet
//
//  Created by Alvaro on 26/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import Foundation

class ALGeneralSelectionDataManager: ALRealtimeClient, ALGeneralSelectionDataManagerProtocol {
    
    var unobserveBlock: (() -> Void)? = nil
    
    func getResourcesListOf(_ section: Section, completion: @escaping ([Any]?) -> Void) {
        unobserveBlock = GET(URLString: section.rawValue, success: completion)
    }
    
    func getResource(_ name: String, completion: @escaping (Data?) -> Void) {
        ALStorageClient.shared.downloadFile(fileName: name, completion: completion)
    }
    
    func dismiss() { unobserveBlock?() }
}
