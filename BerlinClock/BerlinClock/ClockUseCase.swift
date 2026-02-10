//
//  ClockUseCase.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 10/02/2026
//

import Foundation

struct ClockUseCase {
    internal init(timeProvider: any TimeProviderProtocol, clockStateCalculator: any ClockStateCalculatorProtocol) {
        self.timeProvider = timeProvider
        self.clockStateCalculator = clockStateCalculator
    }

    private let timeProvider: TimeProviderProtocol
    private let clockStateCalculator: ClockStateCalculatorProtocol

    func getClockState() -> AsyncStream<PresentationClockState> {
        AsyncStream { continuation in
            listenToTimeProvider(continuation)
        }
    }

    private func listenToTimeProvider(_ continuation: AsyncStream<PresentationClockState>.Continuation) {
        Task {
            for await time in timeProvider.getTime() {
                continuation.yield(
                    calculateState(for: time)
                )
            }
        }
    }

    private func calculateState(for time: Date) -> PresentationClockState {
        let clockState = clockStateCalculator.getClockState(for: time)
        return PresentationClockState(time: time, state: clockState)
    }
}
