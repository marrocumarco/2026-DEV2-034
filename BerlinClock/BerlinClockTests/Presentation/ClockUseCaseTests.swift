//
//  ClockUseCaseTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-034 on 10/02/2026
//

import Foundation
import Testing

@testable import BerlinClock

struct ClockUseCaseTests {

    let sut: ClockUseCase!
    let timeProvider: TimeProviderMock!
    let clockStateCalculator: ClockStateCalculatorMock!

    init() {
        timeProvider = TimeProviderMock()
        clockStateCalculator = ClockStateCalculatorMock()
        sut = ClockUseCase(timeProvider: timeProvider, clockStateCalculator: clockStateCalculator)
    }

    @Test
    func
        `getClockState calls clockStateCalculator and returns a stream of PresentationClockState when the time provider emits a time`()
        async
    {
        var iterator = await sut.getClockState().makeAsyncIterator()

        try? await Task.sleep(nanoseconds: 10_000_000)

        let expectedClockState = ClockState(
            secondsLamp: .yellow,
            fiveHoursRow: [.off, .off, .off, .off],
            singleHoursRow: [.off, .off, .off, .off],
            fiveMinutesRow: [.off, .off, .off, .off, .off, .off, .off, .off, .off, .off, .off],
            singleMinutesRow: [.off, .off, .off, .off]
        )

        clockStateCalculator.expectedClockState = expectedClockState

        let time = Date(timeIntervalSince1970: 0)
        timeProvider.emit(time: time)

        let result: PresentationClockState? = await iterator.next()

        #expect(result != nil)
        #expect(timeProvider.getTimeCalled)
        #expect(clockStateCalculator.getClockStateCalled)
        #expect(result?.time == time)
        #expect(result?.state == expectedClockState)

        timeProvider.continuation?.finish()
    }
}
