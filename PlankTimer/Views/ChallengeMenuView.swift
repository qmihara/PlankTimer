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

    var body: some View {
        NavigationStack {
            List(challengeMenu) { item in
                HStack {
                    Text("DAY \(item.days)")
                        .fontWeight(.heavy)
                    Spacer()
                    switch item.menu {
                    case .challenge(let count):
                        Text("\(count)秒")
                    case .interval:
                        Text("お休み")
                    }
                }
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
    static var previews: some View {
        ChallengeMenuView()
    }
}
#endif
