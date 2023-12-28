//
//  ContentView.swift
//  PlankTimer
//
//  Created by Kyusaku Mihara on 2020/05/02.
//  Copyright © 2020 epohsoft. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store
    @State private var isChallengeMenuPresented = false
    @State private var isActionSheetPresented = false

    var body: some View {
        NavigationView {
            Group {
                switch store.viewState {
                case .challenge(let count):
                    ChallengeView(count: count)
                case .finished:
                    FinishedView()
                case .interval:
                    IntervalView()
                }
            }
            .navigationBarTitle("DAY \(store.days)")
            .navigationBarItems(
                leading: Button(action: {
                    self.isChallengeMenuPresented = true
                }, label: {
                    Image(systemName: "flame")
                }),
                trailing: Button(action: {
                    self.isActionSheetPresented = true
                }, label: {
                    Image(systemName: "trash")
                })
            )
        }
        .accentColor(.red)
        .actionSheet(isPresented: $isActionSheetPresented) {
            ActionSheet(
                title: Text("記録を削除し1日目からやり直します。"),
                message: nil,
                buttons: [
                    .destructive(Text("記録を削除する")) {
                        self.store.clearRecord()
                    },
                    .cancel(),
                ]
            )
        }
        .sheet(isPresented: $isChallengeMenuPresented) {
            ChallengeMenuView()
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Store(userDefaults: .standard))
    }
}
#endif
