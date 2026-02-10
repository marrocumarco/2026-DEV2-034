//
//  ClockUseCase.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 10/02/2026
//

import Foundation

struct ClockUseCase {
    let timeProvider: TimeProviderProtocol
    let clockStateCalculator: ClockStateCalculatorProtocol

    func getClockState() -> AsyncStream<PresentationClockState> {
        AsyncStream { continuation in
            listenToTimeProvider(continuation)
        }
    }

    private func listenToTimeProvider(_ continuation: AsyncStream<PresentationClockState>.Continuation) {
        Task {
            for await time in timeProvider.getTime() {
                let clockState = clockStateCalculator.getClockState(for: time)
                let presentationClockState = PresentationClockState(time: time, state: clockState)

                continuation.yield(
                    presentationClockState
                )
            }
        }
    }
}
