//
//  ErrorHandler.swift
//  GitHubClient
//
//  Created by Nadezhda Demidovich on 9/2/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//

import Foundation


extension Error {
    func getErrorMessage() -> String {
        let errorCode = (self as NSError).code
        var result = ""
        switch errorCode {
        case 300, 301, 307, 309:
            result = "Authentication is failed"
        case 302, 303, 304, 305, 306, 310, 311:
            result = "Http server problem"
        case -998 :
            result = "An unknown error occurred"
        case -999:
            result = "The connection was cancelled"
        case -1001:
            result = "The connection timed out"
        case -1008:
            result = "The connection’s resource is unavailable."
        case -1009:
            result = "The connection failed because the device is not connected to the internet."
        case -1000, -1002, -1003, -1004, -1005, -1006, -1007, -1010 ... -1022:
            result = "The connection failed"
        default:
            result = "Something wrong with application or services"
        }
        return result
    }
}
