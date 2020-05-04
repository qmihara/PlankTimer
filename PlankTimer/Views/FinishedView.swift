//
//  FinishedView.swift
//  PlankTimer
//
//  Created by Kyusaku Mihara on 2020/05/02.
//  Copyright © 2020 epohsoft. All rights reserved.
//

import SwiftUI

struct FinishedView: View {
    var body: some View {
        VStack {
            Image("SportsMan")
                .resizable()
                .scaledToFit()
                .frame(width: 200)

            Text("お疲れさまでした")
                .font(.title)
                .fontWeight(.heavy)
        }
    }
}

#if DEBUG
struct FinishedView_Previews: PreviewProvider {
    static var previews: some View {
        FinishedView()
    }
}
#endif
