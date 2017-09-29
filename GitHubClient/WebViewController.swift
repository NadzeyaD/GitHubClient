//
//  WebViewController.swift
//  GitHubClient
//
//  Created by Nadezhda Demidovich on 9/1/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//

import UIKit
import OAuthSwift
import URLNavigator
import EZAlertController

class WebViewController: OAuthWebViewController {
    
    var targetURL: URL?
    let webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.webView.frame = UIScreen.main.bounds
            self.webView.scalesPageToFit = true
            self.webView.delegate = self
            self.view.addSubview(self.webView)
            loadAddressURL()
    }
    
    override func handle(_ url: URL) {
        targetURL = url
        super.handle(url)
        self.loadAddressURL()
    }
    
    func loadAddressURL() {
        guard let url = targetURL else {
            return
        }
        let req = URLRequest(url: url)
        self.webView.loadRequest(req)

    }
}

// MARK: Extension

extension WebViewController: UIWebViewDelegate {
        func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
            if let url = request.url {
                if url.absoluteString.contains("code=") {
                    let code = getQueryStringParameter(url: url.absoluteString, param: "code")
                    if let receivedCode = code
                    {
                        ServiceManager.instance.getTokenByCode(code: receivedCode, completion: {(token, error) in
                            if token != nil{
                                UserDefaultsManager.setToken(tokenString: token)
                            } else if error != nil {
                                EZAlertController.alert("Error", message: error!.getErrorMessage(), acceptMessage: "OK") {}
                            }
                            self.dismissWebViewController()
                            }
                        )
                    }
                }
            }
            return true
        }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
}
     
