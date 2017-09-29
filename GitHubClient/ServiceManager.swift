//
//  ServiceManager.swift
//  GitHubClient
//
//  Created by Nadezhda Demidovich on 9/1/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//
import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ServiceManager {
    
    //MARK: Constants
    static let instance = ServiceManager()
    let baseUrl = "https://api.github.com/"
    let secret = UserDefaultsManager.getSecret()
    let clientId = UserDefaultsManager.getClientId()
    
    //MARK: Functions
    //Get repositories by user name
    func getRepos(userName: String, completion: @escaping(_ repos: [Repo]?, _ error: Error?) ->() ){
        
        let URL = baseUrl + "users/\(userName)/repos"
        let token = UserDefaultsManager.getToken()!
        let headers: HTTPHeaders = [
            "Authorization": "Token \(token)"
        ]
        Alamofire.request(URL, headers: headers).responseArray { (response: DataResponse<[Repo]>) in
            switch(response.result) {
            case .success(_):
                completion(response.result.value, nil)
                break
            case .failure(_):
                completion(nil, response.error)
                break
            }
        }
    }
    
    //Get token
    func getTokenByCode(code: String, completion: @escaping(_ token: String?, _ error: Error?) ->() ){
        let getTokenPath = "https://github.com/login/oauth/access_token"
        let tokenParams = ["client_id": clientId, "client_secret": secret, "code": code]
        Alamofire.request( getTokenPath, method: .post, parameters: tokenParams)
            .responseString  { (response) in
                switch(response.result) {
                case .success(_):
                    
                    if let value = response.result.value {
                        var token : String? = nil
                        let responseArray = value.components(separatedBy: "&")
                        
                        for responseItem in responseArray {
                            let items = responseItem.components(separatedBy: "=")
                            if items.count > 1 {
                                if items[0] == "access_token" {
                                    token = items[1]
                                    break
                                }
                            }
                        }
                        completion(token, nil)
                    }
                    break
                case .failure(_):
                    completion(nil, response.error)
                    break
                }
        }
    }
 
    
    //Get commits for repo
    func getCommits(userName: String, repoName: String, since: Date, completion: @escaping(_ dog: [Commit]?, _ error: Error? ) ->() ){
        let URL = baseUrl + "repos/\(userName)/\(repoName)/commits"
        
        let token = UserDefaultsManager.getToken()!
        let headers: HTTPHeaders = [
            "Authorization": "Token \(token)"
        ]

        let parameters: Parameters = [
            "since": since
        ]
        Alamofire.request(URL, parameters: parameters, headers: headers).responseArray { (response: DataResponse<[Commit]>) in
            switch(response.result) {
            case .success(_):
                completion(response.result.value, nil)
                break
            case .failure(_):
                completion(nil, response.error)
                break
            }
        }
    }
    
    //Get user name
    func getAuthUserName(completion: @escaping(_ userName: String?, _ error: Error? ) ->() ){
        let URL = baseUrl + "user"
        
        let token = UserDefaultsManager.getToken()!
        let headers: HTTPHeaders = [
            "Authorization": "Token \(token)"
        ]

        Alamofire.request(URL, headers: headers)
            .responseObject  { (response: DataResponse<User>) in
                switch(response.result) {
                case .success(_):
                    
                    completion((response.result.value?.userName), nil)
                    break
                case .failure(_):
                    completion(nil, response.error)
                    break
                }
        }
    } 
}
