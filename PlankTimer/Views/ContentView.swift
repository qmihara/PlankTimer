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
        NavigationStack {
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
            .navigationTitle("DAY \(store.days)")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.isChallengeMenuPresented = true
                    } label: {
                        Image(systemName: "flame")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.isActionSheetPresented = true
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .accentColor(.red)
        .confirmationDialog("", isPresented: $isActionSheetPresented) {
            Button("記録を削除する", role: .destructive) {
                store.clearRecord()
            }
            Button("キャンセル", role: .cancel) {}
        } message: {
            Text("記録を削除し1日目からやり直します。")
        }
        .sheet(isPresented: $isChallengeMenuPresented) {
            ChallengeMenuView()
        }
    }
}

#if DEBUG
#Preview {
    ContentView()
        .environmentObject(Store(userDefaults: .standard))
}
#endif
