//
//  TimeProviderMock.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-034 on 10/02/2026
//

import Foundation
@testable import BerlinClock

class TimeProviderMock: TimeProviderProtocol {

    var getTimeCalled = false
    var continuation: AsyncStream<Date>.Continuation?
    var subscriptionContinuation: CheckedContinuation<Void,Never>?

    func getTime() -> AsyncStream<Date> {

        if let subContinuation = subscriptionContinuation {
            getTimeCalled = true
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

    func emit(time: Date) {
        continuation?.yield(time)
    }

    func finish() {
        continuation?.finish()
    }
}
