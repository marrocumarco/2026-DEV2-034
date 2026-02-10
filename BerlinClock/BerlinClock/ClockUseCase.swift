//
//  ClockUseCase.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 10/02/2026
//

import Foundation

struct ClockUseCase {
    let timeProvider: TimeProviderProtocol
    func getClockState() -> AsyncStream<PresentationClockState> {
        AsyncStream { continuation in
            Task {
                for await _ in timeProvider.getTime() {
                    continuation.yield(PresentationClockState())
                }
            }
        }
    }
}
