//
//  Commit.swift
//  GitHubClient
//
//  Created by Nadezhda Demidovich on 9/1/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//

import ObjectMapper

class Commit : Mappable {
    var hash : String
    var message : String
    var author : String
    var dateString : String
    
    
    init(hash: String, message: String, author: String, date: String){
        self.hash = hash
        self.message = message
        self.author = author
        self.dateString = date
    }
    
    required init?(map: Map){
        hash = ""
        message = ""
        author  = ""
        dateString = ""
    }
    
    func mapping(map: Map) {
        hash <- map["sha"]
        message <- map["commit.message"]
        author <- map["commit.committer.name"]
        dateString <- map["commit.committer.date"]
    }
}
