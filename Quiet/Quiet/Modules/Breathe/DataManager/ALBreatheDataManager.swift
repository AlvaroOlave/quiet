//
//  ALBreatheDataManager.swift
//  Quiet
//
//  Created by Alvaro on 11/02/2019.
//  Copyright © 2019 surflabapps. All rights reserved.
//

import Foundation

class ALBreatheDataManager: ALRealtimeClient, ALBreatheDataManagerProtocol {
    
    var unobserveBlock: (() -> Void)? = nil
    
    func getResourcesList(completion: @escaping ([Any]?) -> Void) {
        unobserveBlock = GET(URLString: "breathe", success: completion)
    }
    
    func getResource(_ name: String, completion: @escaping (Data?) -> Void) {
        ALStorageClient.shared.downloadFile(fileName: name, completion: completion)
    }
    
    func dismiss() { unobserveBlock?() }
}
