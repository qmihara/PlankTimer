//
//  ChallengeRecordTests.swift
//  PlankTimerTests
//
//  Created by Kyusaku Mihara on 2020/05/03.
//  Copyright © 2020 epohsoft. All rights reserved.
//

import XCTest
@testable import PlankTimer

final class ChallengeRecordTests: XCTestCase {
    private typealias DefaultsKeys = ChallengeRecord.DefaultsKeys

    private var userDefaults: UserDefaultsMock!
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()

    override func setUpWithError() throws {
        userDefaults = UserDefaultsMock()
    }

    // MARK: - Test init()

    func testInit() {
        let record = ChallengeRecord(userDefaults: userDefaults, withDate: Date())
        XCTAssertEqual(1, record.days)
        XCTAssertFalse(record.isFinished)
    }

    func testInitWhenContinued1Day() {
        userDefaults.set(1, forKey: DefaultsKeys.continuationDays)
        userDefaults.set(dateFormatter.date(from: "2020-05-01 23:59:59"), forKey: DefaultsKeys.lastChallengedDate)

        let record = ChallengeRecord(userDefaults: userDefaults, withDate: dateFormatter.date(from: "2020-05-02 00:00:00")!)
        XCTAssertEqual(2, record.days)
        XCTAssertFalse(record.isFinished)
    }

    func testInitWhen2DaysInterval() {
        userDefaults.set(1, forKey: DefaultsKeys.continuationDays)
        userDefaults.set(dateFormatter.date(from: "2020-05-01 23:59:59"), forKey: DefaultsKeys.lastChallengedDate)

        let record = ChallengeRecord(userDefaults: userDefaults, withDate: dateFormatter.date(from: "2020-05-03 00:00:00")!)
        XCTAssertEqual(1, record.days)
        XCTAssertFalse(record.isFinished)
    }

    func testInitWhenContinuedDaysExistsButLastChallengedDayNotExists() {
        userDefaults.set(3, forKey: DefaultsKeys.continuationDays)

        let record = ChallengeRecord(userDefaults: userDefaults, withDate: Date())
        XCTAssertEqual(1, record.days)
        XCTAssertFalse(record.isFinished)
    }

    func testInitWhenSameDate() {
        userDefaults.set(3, forKey: DefaultsKeys.continuationDays)
        userDefaults.set(dateFormatter.date(from: "2020-05-01 23:59:59"), forKey: DefaultsKeys.lastChallengedDate)

        let record = ChallengeRecord(userDefaults: userDefaults, withDate: dateFormatter.date(from: "2020-05-01 23:59:59")!)
        XCTAssertEqual(3, record.days)
        XCTAssertTrue(record.isFinished)
    }

    // MARK: - Test saveRecord()

    func testSaveRecord() {
        userDefaults.set(5, forKey: DefaultsKeys.continuationDays)
        userDefaults.set(dateFormatter.date(from: "2020-05-01 23:59:59"), forKey: DefaultsKeys.lastChallengedDate)

        let record = ChallengeRecord(userDefaults: userDefaults, withDate: dateFormatter.date(from: "2020-05-02 00:00:00")!)
        record.saveRecord(withChallengedDate: dateFormatter.date(from: "2020-05-02 10:00:00")!)

        XCTAssertEqual(6, userDefaults.integer(forKey: DefaultsKeys.continuationDays))
        XCTAssertEqual(dateFormatter.date(from: "2020-05-02 10:00:00"), userDefaults.object(forKey: DefaultsKeys.lastChallengedDate) as? Date)
    }

    // MARK: - Test clearRecord()

    func testClearRecord() {
        userDefaults.set(10, forKey: DefaultsKeys.continuationDays)
        userDefaults.set(dateFormatter.date(from: "2020-05-01 23:59:59"), forKey: DefaultsKeys.lastChallengedDate)

        var record = ChallengeRecord(userDefaults: userDefaults, withDate: dateFormatter.date(from: "2020-05-01 00:00:00")!)
        record.clearRecord()

        XCTAssertNil(userDefaults.object(forKey: DefaultsKeys.continuationDays))
        XCTAssertNil(userDefaults.object(forKey: DefaultsKeys.lastChallengedDate))
        XCTAssertEqual(1, record.days)
        XCTAssertFalse(record.isFinished)
    }
 }
