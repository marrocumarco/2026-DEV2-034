//
//  ClockUseCaseTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-034 on 10/02/2026
//

import Testing
import Foundation
@testable import BerlinClock

struct ClockUseCaseTests {

    let sut: ClockUseCase!
    let timeProvider: TimeProviderMock!
    let clockStateCalculator: ClockStateCalculatorMock!

    init() {
        timeProvider = TimeProviderMock()
        clockStateCalculator = ClockStateCalculatorMock()
        sut = ClockUseCase(timeProvider: timeProvider)
    }

    @Test func `getClockState returns a stream of PresentationClockState when the time provider emits a time`() async {
        var iterator = await sut.getClockState().makeAsyncIterator()

        let date = Date(timeIntervalSince1970: 0)
        timeProvider.emit(time: date)

        let result: PresentationClockState? = await iterator.next()

        #expect(result != nil)
        #expect(timeProvider.getTimeCalled)
     }
}
