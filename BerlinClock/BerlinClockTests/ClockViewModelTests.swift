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
    var getClockStateCalled = false
    func getClockState() -> AsyncStream<PresentationClockState> {
        getClockStateCalled = true
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
