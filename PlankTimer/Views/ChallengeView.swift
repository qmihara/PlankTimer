//
//  ChallengeView.swift
//  PlankTimer
//
//  Created by Kyusaku Mihara on 2020/05/02.
//  Copyright © 2020 epohsoft. All rights reserved.
//

import SwiftUI

private enum ChallengeViewState {
    case initial
    case challenging
    case suspend

    var isStarting: Bool {
        return self != .initial
    }
}

struct ChallengeView: View {

    @EnvironmentObject var store: Store
    var count: Int
    @State private var state: ChallengeViewState = .initial
    @State private var currentProgress: Float = 0
    @State private var currentCount: Double = 0
    @State private var timer: Timer.TimerPublisher = Timer.publish(every: 0, on: .current, in: .common) {
        willSet {
            timer.connect().cancel()
        }
    }
    var body: some View {
        VStack {
            Spacer()

            ZStack {
                ProgressView(progress: currentProgress)

                Text(String(format: "%.1f", self.currentCount))
                    .font(.system(size: 48, weight: .black, design: .monospaced))
                    .foregroundColor(.red)
            }
            .frame(width: 200)
            .padding()

            Spacer()

            Image(state.isStarting ? "PlankMan" : "StrechMan")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 150, alignment: .bottom)

            Group<AnyView> {
                switch state {
                case .initial:
                    return AnyView(
                        Button(action: {
                            self.startChallenge()
                        }) {
                            Text("チャレンジする")
                                .fontWeight(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                        }
                        .background(Color.red)
                        .cornerRadius(40)
                        .padding()
                    )
                case .challenging:
                    return AnyView(
                        Button(action: {
                            self.suspendChallenge()
                        }) {
                            Text("ストップ")
                                .fontWeight(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.red)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.red, lineWidth: 2)
                                )
                        }
                        .padding()
                        .onAppear {
                            UIApplication.shared.isIdleTimerDisabled = true
                        }
                        .onDisappear {
                            UIApplication.shared.isIdleTimerDisabled = false
                        }
                    )
                case .suspend:
                    return AnyView(
                        HStack {
                            Button(action: {
                                self.prepareForRestart()
                            }) {
                                Text("やり直す")
                                    .fontWeight(.black)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.red)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke(Color.red, lineWidth: 2)
                                )
                            }
                            .padding()

                            Button(action: {
                                self.startChallenge()
                            }) {
                                Text("再開")
                                    .fontWeight(.black)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                            }
                            .background(Color.red)
                            .cornerRadius(40)
                            .padding()
                        }
                    )
                }
            }
        }.onReceive(timer) { _ in
            self.countdown()
        }.onAppear {
            self.currentCount = Double(self.count)
            self.currentProgress = 0
        }
    }

    private func countdown() {
        currentCount -= 0.1
        let count = Double(self.count)
        currentProgress = Float((count - currentCount) / count)
        if currentCount <= 0 {
            finishChallenge()
        }
    }

    private func startTimer() {
        timer = Timer.publish(every: 0.1, on: .current, in: .common)
        _ = timer.connect()
    }

    private func stopTimer() {
        timer.connect().cancel()
    }

    private func startChallenge() {
        startTimer()
        state = .challenging
    }

    private func suspendChallenge() {
        stopTimer()
        state = .suspend
    }

    private func prepareForRestart() {
        stopTimer()
        state = .initial
        currentCount = Double(count)
        currentProgress = 0
    }

    private func finishChallenge() {
        stopTimer()
        state = .initial
        store.viewState = .finished
        store.saveRecord()
        currentCount = 0
        currentProgress = 1.0
    }
}

#if DEBUG
struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView(count: 30)
    }
}
#endif
