//
//  ClockViewModelTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-034 on 10/02/2026
//

import Foundation
import SwiftUI
import Testing

@testable import BerlinClock

class ClockUseCaseMock: ClockUseCaseProtocol {
    var continuation: AsyncStream<PresentationClockState>.Continuation?

    var getClockStateCalled = false

    func getClockState() -> AsyncStream<PresentationClockState> {
        getClockStateCalled = true
        return AsyncStream { continuation = $0 }
    }

    func emit(state: PresentationClockState) {
        continuation?.yield(state)
    }
}

struct ClockViewModelTests {
    let sut: ClockViewModel!
    let useCaseMock: ClockUseCaseMock!

    init() {
        useCaseMock = ClockUseCaseMock()
        sut = ClockViewModel(clockUseCase: useCaseMock)
    }

    @Test func `startClock calls the method getClockState of the use case`() {

        sut.startClock()

        #expect(useCaseMock.getClockStateCalled)
    }
}
