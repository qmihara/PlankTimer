//
//  IntervalView.swift
//  PlankTimer
//
//  Created by Kyusaku Mihara on 2020/05/02.
//  Copyright © 2020 epohsoft. All rights reserved.
//

import SwiftUI

struct IntervalView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        VStack {
            Image("SleepCat")
                .resizable()
                .scaledToFit()
                .frame(width: 200)

            Text("今日はお休みです")
                .font(.title)
                .fontWeight(.heavy)
        }
        .onAppear {
            self.store.saveRecord()
        }
    }
}

#if DEBUG
struct IntervalView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalView()
    }
}
#endif
