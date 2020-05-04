//
//  Store.swift
//  PlankTimer
//
//  Created by Kyusaku Mihara on 2020/05/02.
//  Copyright © 2020 epohsoft. All rights reserved.
//

import Foundation

final class Store: ObservableObject {
    @Published var days: Int
    @Published var viewState: ViewState

    private let userDefaults: UserDefaults
    private var challengeRecord: ChallengeRecord

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        self.challengeRecord = ChallengeRecord(userDefaults: userDefaults)
        self.days = challengeRecord.days

        switch ChallengeMenu(days: challengeRecord.days) {
        case .challenge(let count):
            self.viewState = challengeRecord.isFinished ? .finished : .challenge(count)
        case .interval:
            self.viewState = .interval
        }
    }

    func saveRecord() {
        challengeRecord.saveRecord()
    }

    func clearRecord() {
        challengeRecord.clearRecord()
        days = challengeRecord.days
        switch ChallengeMenu(days: challengeRecord.days) {
        case .challenge(let count):
            viewState = challengeRecord.isFinished ? .finished : .challenge(count)
        case .interval:
            viewState = .interval
        }
    }
}
