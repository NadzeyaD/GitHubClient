//
//  DateExtension.swift
//  GitHubClient
//
//  Created by Nadezhda Demidovich on 9/2/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//

import Foundation

public let mainDateTimeFormat = "MM/dd/yyyy HH:mm:ss"
public let gitHubDateFormat = "yyy-MM-ddTHH:mm:ssZ"

extension Date {
    func toString(dateFormat format  : String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func getDateMonthAgo() -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: -1, to: self)
    }
}

extension String {
    func toDate( dateFormat format  : String ) -> Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}
