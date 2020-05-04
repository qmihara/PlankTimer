//
//  ChallengeMenu.swift
//  PlankTimer
//
//  Created by Kyusaku Mihara on 2020/05/02.
//  Copyright © 2020 epohsoft. All rights reserved.
//

import Foundation

enum ChallengeMenu {
    case challenge(Int)
    case interval

    init(days: Int) {
        switch days {
        case 0...2:
            self = .challenge(20)
        case 3...4:
            self = .challenge(30)
        case 5:
            self = .challenge(40)
        case 6:
            self = .interval
        case 7...8:
            self = .challenge(45)
        case 9...11:
            self = .challenge(60)
        case 12:
            self = .challenge(90)
        case 13:
            self = .interval
        case 14...15:
            self = .challenge(90)
        case 16...17:
            self = .challenge(120)
        case 18:
            self = .challenge(150)
        case 19:
            self = .interval
        case 20...21:
            self = .challenge(150)
        case 22...23:
            self = .challenge(180)
        case 24...25:
            self = .challenge(210)
        case 26:
            self = .interval
        case 27...28:
            self = .challenge(240)
        case 29:
            self = .challenge(270)
        case _ where days > 29:
            self = .challenge(300)
        default:
            self = .interval
        }
    }
}
