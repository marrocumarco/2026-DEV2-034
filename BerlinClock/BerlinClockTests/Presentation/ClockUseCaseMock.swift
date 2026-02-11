//
//  ClockUseCaseMock.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 11/02/2026
//
	
@testable import BerlinClock

class ClockUseCaseMock: ClockUseCaseProtocol {
    var continuation: AsyncStream<PresentationClockState>.Continuation?
    private var subscriptionContinuation: CheckedContinuation<Void, Never>?

    var getClockStateCalled = false

    func getClockState() -> AsyncStream<PresentationClockState> {
        if let subContinuation = subscriptionContinuation {
            getClockStateCalled = true

            subContinuation.resume()
            subscriptionContinuation = nil
        }
        return AsyncStream {
            continuation = $0
        }
    }

    func waitForSubscription() async {
        await withCheckedContinuation { continuation in
            self.subscriptionContinuation = continuation
        }
    }

    func emit(state: PresentationClockState) {
        continuation?.yield(state)
    }

    func finish() {
        continuation?.finish()
    }
}
