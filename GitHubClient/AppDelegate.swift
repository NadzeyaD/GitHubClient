//
//  AppDelegate.swift
//  GitHubClient
//
//  Created by Nadezhda Demidovich on 9/1/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//

import UIKit
import OAuthSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else { return false }
        self.window?.backgroundColor = .white
        
        setSecureData()
        // Initialize navigation map
        NavigationMap.setup()
        
        window.makeKeyAndVisible()
        window.rootViewController = UINavigationController(rootViewController: AuthorizationViewController())
        return true
    }
    
    
    
    
    //TODO: move to save place
    func setSecureData(){
        UserDefaultsManager.setSecret(value: "a70299d1f4d19ba6cb573cb505150534b8d088cb")
        UserDefaultsManager.setClientId(value: "64be6f0d8d8af9bc5ac1")
    }
}

