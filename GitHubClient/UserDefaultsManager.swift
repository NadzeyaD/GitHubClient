//
//  UserDefaultsManager.swift
//  GitHubClient
//
//  Created by Nadezhda Demidovich on 9/1/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//

import Foundation

//
//  UserDefaultsManager.swift
//  SabakarApplication
//
//  Created by Nadezhda Demidovich on 7/9/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//

import Foundation

struct UserDefaultsManager {

    static let userNameKey = "currentUserName"
    static let cllientIdKey = "clientId"
    static let token = "token"
    static let secretKey = "secret"
    
    static func setSecret(value: String){
        UserDefaults.standard.set(value, forKey: secretKey)
        UserDefaults.standard.synchronize()
    }
    
    static func getSecret() -> String {
        return UserDefaults.standard.string(forKey: secretKey)!
    }
    
    static func setCurrentUser(name : String?){
        UserDefaults.standard.set(name, forKey: userNameKey)
        UserDefaults.standard.synchronize()
    }
    
    static func getCurrentUser() -> String? {
        return UserDefaults.standard.string(forKey: userNameKey)
    }
    
    static func setClientId(value : String){
        UserDefaults.standard.set(value, forKey: cllientIdKey)
        UserDefaults.standard.synchronize()
    }
    
    static func getClientId() -> String {
        return UserDefaults.standard.string(forKey: cllientIdKey)!
    }
    
    static func setToken(tokenString : String?){
        UserDefaults.standard.set(tokenString, forKey: token)
        UserDefaults.standard.synchronize()
    }
    
    static func getToken() -> String? {
        return UserDefaults.standard.string(forKey: token)
    }
    
}
