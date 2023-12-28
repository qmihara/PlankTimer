//
//  ChallengeMenuView.swift
//  PlankTimer
//
//  Created by Kyusaku Mihara on 2020/05/15.
//  Copyright © 2020 epohsoft. All rights reserved.
//

import SwiftUI

struct ChallengeMenuView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: Store

    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                List(challengeMenu) { item in
                    HStack {
                        Text("DAY \(item.days)")
                            .fontWeight(item.days == store.days ? .heavy : .regular)
                        Spacer()
                        Group {
                            switch item.menu {
                            case .challenge(let count):
                                Text("\(count)秒")
                            case .interval:
                                Text("お休み")
                            }
                        }
                        .fontWeight(item.days == store.days ? .heavy : .regular)
                    }
                    .id(item.days)
                }
                .navigationTitle("プランクチャレンジ")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Text("完了")
                        }
                    }
                }
                .onAppear {
                    proxy.scrollTo(store.days, anchor: .top)
                }
            }
        }
        .accentColor(.red)
    }

    private var challengeMenu: [Item] {
        return (1...30).map { Item(days: $0, menu: ChallengeMenu(days: $0)) }
    }
}

extension ChallengeMenuView {
    struct Item: Identifiable {
        var id: Int { return days }
        var days: Int
        var menu: ChallengeMenu
    }
}

#if DEBUG
struct ChallengeMenuView_Previews: PreviewProvider {
    private static var userDefaults: UserDefaults {
        let userDefaults = UserDefaults()
        userDefaults.set(20, forKey: ChallengeRecord.DefaultsKeys.continuationDays)
        return userDefaults
    }
    static var previews: some View {
        ChallengeMenuView()
            .environmentObject(Store(userDefaults: userDefaults))
    }
}
#endif
