//
//  CountdownView.swift
//  PlankTimer
//
//  Created by Kyusaku Mihara on 2020/05/02.
//  Copyright © 2020 epohsoft. All rights reserved.
//

import SwiftUI
import Combine

struct CountdownView: View {
    @Binding var isStart: Bool
    @State private var count: Int = 0
    @State private var timer: Timer.TimerPublisher = Timer.publish(every: 0, on: .current, in: .common) {
        willSet {
            timer.connect().cancel()
        }
    }
    var body: some View {
        VStack {
        ZStack {
            ProgressView(progress: 0.4)
                .frame(width: 200, height: 200)
                .padding()

            Text("20")
                .font(.system(size: 48, weight: .black, design: .monospaced))
                .foregroundColor(.red)
        }
            Button(action: {
                self.startTimer()
            }) {
                Text("Timer start")
            }
            Button(action: {
                self.stopTimer()
                self.count = 0
            }) {
                Text("Timer stop")
            }
        }
        .onReceive(timer) { _ in
            self.count += 1
            print("count:\(self.count)")
        }
    }

    init(isStart: Binding<Bool>) {
        self._isStart = isStart
    }

    private func startTimer() {
        timer = Timer.publish(every: 1, on: .current, in: .common)
        _ = timer.connect()
    }

    private func stopTimer() {
        timer.connect().cancel()
    }
}

#if DEBUG
struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(isStart: Binding.constant(false))
    }
}
#endif
