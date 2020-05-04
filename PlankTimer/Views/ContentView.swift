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
    @State private var isActionSheetPresented = false

    var body: some View {
        NavigationView {
            Group<AnyView> {
                switch store.viewState {
                case .challenge(let count):
                    return AnyView(
                        ChallengeView(count: count)
                    )
                case .finished:
                    return AnyView(
                        FinishedView()
                    )
                case .interval:
                    return AnyView(
                        IntervalView()
                    )
                }
            }
            .navigationBarTitle("DAY \(store.days)")
            .navigationBarItems(
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
