//
//  ViewControllerExtensions.swift
//  GitHubClient
//
//  Created by Nadezhda Demidovich on 9/1/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//

import UIKit

extension UIViewController {
    var statusBarHeight : Int {
        return Int(UIApplication.shared.statusBarFrame.height)
    }
}
