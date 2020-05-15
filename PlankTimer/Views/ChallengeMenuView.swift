//
//  ChallengeMenuView.swift
//  PlankTimer
//
//  Created by Kyusaku Mihara on 2020/05/15.
//  Copyright © 2020 epohsoft. All rights reserved.
//

import SwiftUI

struct ChallengeMenuView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List(challengeMenu) { item in
                HStack {
                    Text("DAY \(item.days)")
                        .fontWeight(.heavy)
                    Spacer()
                    Group<Text> {
                        switch item.menu {
                        case .challenge(let count):
                            return Text("\(count)秒")
                        case .interval:
                            return Text("お休み")
                        }
                    }
                }
            }
            .navigationBarTitle("プランクチャレンジ", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("完了")
                })
            )
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
