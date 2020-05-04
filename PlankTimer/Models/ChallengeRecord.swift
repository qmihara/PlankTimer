//
//  ChallengeRecord.swift
//  PlankTimer
//
//  Created by Kyusaku Mihara on 2020/05/03.
//  Copyright © 2020 epohsoft. All rights reserved.
//

import Foundation

struct ChallengeRecord {
    struct DefaultsKeys {
        static let continuationDays = "ContinuationDays"
        static let lastChallengedDate = "LastChallengedDate"
    }

    var days: Int
    var isFinished: Bool = false

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults, withDate date: Date = Date()) {
        self.userDefaults = userDefaults

        let days = userDefaults.integer(forKey: DefaultsKeys.continuationDays)
        guard let lastChallengedDate = userDefaults.object(forKey: DefaultsKeys.lastChallengedDate) as? Date else {
            self.days = 1
            return
        }

        let dayInterval = Calendar.current.dayInterval(from: lastChallengedDate, to: date)
        if dayInterval == 1 {
            self.days = days + 1
        } else if dayInterval == 0 {
            self.days = days
            isFinished = true
        } else {
            self.days = 1
        }
    }

    func saveRecord(withChallengedDate challengedDate: Date = Date()) {
        userDefaults.set(days, forKey: DefaultsKeys.continuationDays)
        userDefaults.set(challengedDate, forKey: DefaultsKeys.lastChallengedDate)
    }

    mutating func clearRecord() {
        userDefaults.removeObject(forKey: DefaultsKeys.continuationDays)
        userDefaults.removeObject(forKey: DefaultsKeys.lastChallengedDate)
        days = 1
        isFinished = false
    }
}

private extension Calendar {
    func dayInterval(from: Date, to: Date) -> Int {
        let ymdFrom = date(bySettingHour: 0, minute: 0, second: 0, of: from) ?? from
        let ymdTo = date(bySettingHour: 0, minute: 0, second: 0, of: to) ?? to
        let dateComponents = self.dateComponents([.day], from: ymdFrom, to: ymdTo)
        return dateComponents.day ?? -1
    }
}
