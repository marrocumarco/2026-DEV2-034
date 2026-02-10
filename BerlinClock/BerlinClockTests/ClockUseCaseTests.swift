//
//  ClockUseCaseTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-034 on 10/02/2026
//

import Testing
@testable import BerlinClock

class TimeProviderMock: TimeProviderProtocol {

}

class ClockStateCalculatorMock: ClockStateCalculatorProtocol {

}

struct ClockUseCaseTests {

    let sut: ClockUseCase!
    let timeProvider: TimeProviderMock!
    let clockStateCalculator: ClockStateCalculatorMock!

    init() {
        sut = ClockUseCase()
        timeProvider = TimeProviderMock()
        clockStateCalculator = ClockStateCalculatorMock()
    }

}
