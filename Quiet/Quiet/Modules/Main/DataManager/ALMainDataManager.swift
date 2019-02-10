//
//  ALMainDataManager.swift
//  Quiet
//
//  Created by Alvaro on 14/01/2019.
//  Copyright © 2019 surflabapps. All rights reserved.
//

import Foundation

class ALMainDataManager: ALRealtimeClient, ALMainDataManagerProtocol {
    
    var asmrBlock:(() -> Void)?
    var sleepCastBlock:(() -> Void)?
    var sleepBlock:(() -> Void)?
    var landscapeBlock:(() -> Void)?
    var yogaBlock:(() -> Void)?
    
    func getAllResourceLists() {
        asmrBlock = GET(URLString: Section.ASMR.rawValue) { resp in self.asmrBlock?() }
        sleepCastBlock = GET(URLString: Section.SleepCast.rawValue) { resp in self.sleepCastBlock?() }
        sleepBlock = GET(URLString: Section.Sleep.rawValue) { resp in self.sleepBlock?() }
        landscapeBlock = GET(URLString: Section.Landscapes.rawValue) { resp in self.landscapeBlock?() }
        yogaBlock = GET(URLString: Section.YogaStretch.rawValue) { resp in self.yogaBlock?() }
    }
    
    func getAllDailyAdvices(_ completion: @escaping ([String]?) -> Void) {
        _ = GET(URLString: "dailyAdvice") { completion($0 as? [String]) }
    }
    
    func getAllAvailableBackgrounds(_ completion: @escaping ([Any]?) -> Void) {
        _ = GET(URLString: "background") { completion($0) }
    }
    
    func downloadbackground(_ name: String, _ completion: @escaping (Bool) -> Void) {
        ALStorageClient.shared.downloadFile(fileName: name) { completion($0 != nil) }
    }
    
    func getLocalFile(_ named: String, _ completion: @escaping (Data?) -> Void) {
        ALStorageClient.shared.getLocalFile(named, completion: completion)
    }
}
