//
//  User.swift
//  GitHubClient
//
//  Created by Nadezhda Demidovich on 9/2/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var userName : String?
    
    
    init(userName: String){
        self.userName = userName
    }
    
    required init?(map: Map){
        userName = ""
    }
    
    func mapping(map: Map) {
        userName <- map["login"]
    }
}
