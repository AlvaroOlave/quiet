//
//  ALUserTokenManager.swift
//  Quiet
//
//  Created by Alvaro on 12/12/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import KeychainSwift

struct ALUserToken {
    var expireDate: Double
    
    init(with expireDate: Double) {
        self.expireDate = expireDate
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
    
    func isPremium() -> Bool { return expireDate > Date().timeIntervalSince1970 }
}

class ALUserTokenManager {
    static let shared = ALUserTokenManager()
    var currentUser: ALUserToken {
        didSet {
            if self.currentUser.expireDate > 0 && !self.currentUser.isPremium() {
                ALPurchaseManager.shared.receiptValidation()
            }
        }
    }
    
    init() { currentUser = ALUserTokenManager.getUserToken() }
    
    func setExpireDate(_ date: Double) { setUserToken(ALUserToken(with: date)) }
    
    func setUserToken(_ userToken: ALUserToken) {
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        keychain.set(ALUserToken.archive(userToken), forKey: "AL_USER_TOKEN_PURCHASED")
        currentUser = userToken
    }
    
    static func getUserToken() -> ALUserToken {
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        
        if let pass = keychain.getData("AL_USER_TOKEN_PURCHASED") {
            return ALUserToken.unarchive(d: pass)
        }
        return ALUserToken(with: 0)
    }
    
    static func removeUser() {
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        keychain.delete("AL_USER_TOKEN_PURCHASED")
    }
}
