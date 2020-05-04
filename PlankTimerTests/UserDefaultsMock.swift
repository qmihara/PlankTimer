//
//  UserDefaultsMock.swift
//  PlankTimerTests
//
//  Created by Kyusaku Mihara on 2020/05/03.
//  Copyright © 2020 epohsoft. All rights reserved.
//

import Foundation

class UserDefaultsMock: UserDefaults {
    private var objects = [String: Any]()

    override func object(forKey defaultName: String) -> Any? {
        return objects[defaultName]
    }

    override func set(_ value: Any?, forKey defaultName: String) {
        objects[defaultName] = value
    }

    override func removeObject(forKey defaultName: String) {
        objects.removeValue(forKey: defaultName)
    }
}
