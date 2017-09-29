//
//  NavigationMap.swift
//  GitHubClient
//
//  Created by Nadezhda Demidovich on 9/1/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//

import Foundation
import URLNavigator


struct NavigationMap {
     
    static func setup() {
        Navigator.scheme = "GitHubClient"
        /*Navigator.map("navigator://login/", AuthorizationViewController.self)*/
        Navigator.map("navigator://repos/<userName>", ReposViewController.self)
        Navigator.map("navigator://commits/<userName>/<repoName>", CommitsViewController.self)
    }
}
