//
//  Repo.swift
//  GitHubClient
//
//  Created by Nadezhda Demidovich on 9/1/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//

import Foundation
import ObjectMapper

class Repo: Mappable {
    var name : String
    var description : String
    var author : String
    var date : String
    
    
    init(name: String, description: String, author: String, date: String){
        self.name = name
        self.description = description
        self.author = author
        self.date = date
    }
    
    required init?(map: Map){
        name = ""
        description = ""
        author  = ""
        date = ""
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        description <- map["description"]
        author <- map["owner.login"]
        date <- map["updated_at"]
    }
}
