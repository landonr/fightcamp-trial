//
//  Date.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import Foundation

extension Date {
    func isToday() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
}
