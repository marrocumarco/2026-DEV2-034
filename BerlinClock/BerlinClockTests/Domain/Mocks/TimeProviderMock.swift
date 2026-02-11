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

    func getTime() -> AsyncStream<Date> {
        getTimeCalled = true
        return AsyncStream {
            continuation = $0
        }
    }

    func emit(time: Date) {
        continuation?.yield(time)
    }
}
