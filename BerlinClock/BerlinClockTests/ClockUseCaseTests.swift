//
//  ClockUseCaseTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-034 on 10/02/2026
//

import Testing

@testable import BerlinClock

struct ClockUseCaseTests {

    let sut: ClockUseCase!
    let timeProvider: TimeProviderMock!
    let clockStateCalculator: ClockStateCalculatorMock!

    init() {
        sut = ClockUseCase()
        timeProvider = TimeProviderMock()
        clockStateCalculator = ClockStateCalculatorMock()
    }

    @Test func `getClockState returns a stream of PresentationClockState`() {
        let iterator = sut.getClockState().makeAsyncIterator()

        let result: PresentationClockState = try await iterator.next()

        #expect(result != nil)
     }
}
