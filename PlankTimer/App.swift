//
//  App.swift
//  PlankTimer
//
//  Created by Kyusaku Mihara on 2023/12/28.
//  Copyright © 2023 epohsoft. All rights reserved.
//

import SwiftUI

@main
struct PlankTimerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Store(userDefaults: .standard))
        }
    }
}
