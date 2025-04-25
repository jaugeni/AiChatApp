//
//  Date+EXT.swift
//  AiChatApp
//
//  Created by Yauheni Ivaniuk on 4/25/25.
//

import Foundation

extension Date {
    func addingTimeInterval(days: Int = 0, hours: Int = 0, minutes: Int = 0) -> Date {
        let dayInterval = TimeInterval(days * 24 * 60)
        let hourinterval = TimeInterval(hours * 60 * 60)
        let minuteInterval = TimeInterval(minutes * 60)
        return self.addingTimeInterval(dayInterval + hourinterval + minuteInterval)
    }
}
