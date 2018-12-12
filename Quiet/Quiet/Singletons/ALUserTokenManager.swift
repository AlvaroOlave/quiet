//
//  ALUserTokenManager.swift
//  Quiet
//
//  Created by Alvaro on 12/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import KeychainSwift

struct ALUserToken {
    var expireDate: Date
    var data: Data?
    
    init(with expireDate: Date, data: Data?) {
        
        self.expireDate = expireDate
        self.data = data
    }
    
    static func archive(_ w: ALUserToken) -> Data {
        var fw = w
        return Data(bytes: &fw, count: MemoryLayout<ALUserToken>.stride)
    }
    
    static func unarchive(d:Data) -> ALUserToken {
        guard d.count == MemoryLayout<ALUserToken>.stride else { fatalError("BOOM!") }
        
        var userToken:ALUserToken?
        d.withUnsafeBytes({(bytes: UnsafePointer<ALUserToken>)->Void in
            userToken = UnsafePointer<ALUserToken>(bytes).pointee
        })
        return userToken!
    }
}

class ALUserTokenManager {
    
    static let shared = ALUserTokenManager()
    
    func setUserToken(_ userToken: ALUserToken) {
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        keychain.set(ALUserToken.archive(userToken), forKey: "AL_USER_TOKEN_PURCHASED")
    }
    
    func getUserToken() -> ALUserToken? {
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        
        if let pass = keychain.getData("AL_USER_TOKEN_PURCHASED") {
            return ALUserToken.unarchive(d: pass)
        }
        return nil
    }
}
