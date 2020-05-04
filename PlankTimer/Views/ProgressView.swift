//
//  ProgressView.swift
//  PlankTimer
//
//  Created by Kyusaku Mihara on 2020/05/02.
//  Copyright © 2020 epohsoft. All rights reserved.
//

import SwiftUI

struct ProgressView: View {
    private static let lineWidth: CGFloat = 24
    var progress: Float

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: type(of: self).lineWidth)
                .opacity(0.1)
                .foregroundColor(Color.red)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(1.0 - self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: type(of: self).lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .rotation3DEffect(Angle(degrees: 180.0), axis: (x: 0, y: 1, z: 0))
                .animation(.linear)
        }
    }
}

#if DEBUG
struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(progress: 0.4)
    }
}
#endif
