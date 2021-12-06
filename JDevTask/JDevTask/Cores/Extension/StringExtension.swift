//
//  StringExtension.swift
//  JDevTask
//
//  Created by Tung Vu on 02/12/21.
//  Copyright © 2020 news. All rights reserved.
//

import Foundation

import Foundation

extension String {
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
    var currencyFormatted: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = ","
        formatter.currencyDecimalSeparator = ","
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        let amount = (self as NSString).doubleValue as NSNumber
        return (formatter.string(from: amount) ?? "")
        
    }
}

// convert to Date
extension String {
    var convertToISODate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
        let date = dateFormatter.date(from: self)
        return date
    }
}
