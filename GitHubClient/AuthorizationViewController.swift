//
//  ViewController.swift
//  GitHubClient
//
//  Created by Nadezhda Demidovich on 9/1/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//

import UIKit
import URLNavigator
import OAuthSwift
import EZAlertController

class AuthorizationViewController: UIViewController{

    //MARK: Properties
    var oauthswift: OAuthSwift?
    lazy var internalWebViewController: WebViewController = {
        let controller = WebViewController()
        controller.view = UIView(frame: UIScreen.main.bounds)
        controller.delegate = self
        controller.viewDidLoad()
        return controller
    }()
    
    //MARK: Constants
    let secret = UserDefaultsManager.getSecret()
    let clientId = UserDefaultsManager.getClientId()
    let callbackUrl = "https://github.com/NadzeyaD"
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (UserDefaultsManager.getToken() == nil){
            doOAuthGithub()
        } else {
            let userName = UserDefaultsManager.getCurrentUser()
            if userName == nil {
                ServiceManager.instance.getAuthUserName(){
                    (name, error) in
                    if name != nil {
                        UserDefaultsManager.setCurrentUser(name: name)
                        Navigator.present("navigator://repos/\(name!)")
                    } else if error != nil {
                        EZAlertController.alert("Error", message: error!.getErrorMessage(), acceptMessage: "OK") {}
                    }
                }
            } else {
                Navigator.present("navigator://repos/\(userName!)")
            }
        }

    }
    
    func doOAuthGithub(){
        let oauthswift = OAuth2Swift(
            consumerKey:    clientId,
            consumerSecret: secret,
            authorizeUrl:   "https://github.com/login/oauth/authorize",
            responseType:   "token"
        )
        self.oauthswift = oauthswift
        oauthswift.authorizeURLHandler = getURLHandler()
        let state = generateState(withLength: 20)
    
        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: callbackUrl)!, scope: "user,repo", state: state,
            success: { credential, response, parameters in
                
        },
            failure: { error in
                EZAlertController.alert("Error", message: error.getErrorMessage(), acceptMessage: "OK") {}
                
        }
        )
    }
    
    // MARK: handler
    func getURLHandler() -> OAuthSwiftURLHandlerType {

        if internalWebViewController.parent == nil {
            self.addChildViewController(internalWebViewController)
        }
        return internalWebViewController
        
    }
}


extension AuthorizationViewController: OAuthWebViewControllerDelegate {

    
    func oauthWebViewControllerDidPresent() {
        
    }
    func oauthWebViewControllerDidDismiss() {
        
    }
    
    func oauthWebViewControllerWillAppear() {
        
    }
    func oauthWebViewControllerDidAppear() {
        
    }
    func oauthWebViewControllerWillDisappear() {
        
    }
    func oauthWebViewControllerDidDisappear() {
        oauthswift?.cancel()
    }
}

