//
//  ClockStateCalculatorTests.swift
//  ClockStateCalculatorTests
//
//  Created by 2026-DEV2-034 on 08/02/2026.
//

import Testing
import Foundation
@testable import BerlinClock

@MainActor
struct ClockStateCalculatorTests {

    var sut: ClockStateCalculator!

    init() {
        sut = ClockStateCalculator()
    }

    @Test("when the seconds are even, the seconds lamp is active and yellow")
    func getClockState_secondsEven_secondsLampActiveYellow() {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let time = dateFormatter.date(from: "12:34:56")

        let expectedResult = LampState.yellow

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.secondsLamp)

    }

    @Test("when the seconds are odd, the seconds lamp is inactive")
    func getClockState_secondsOdd_secondsLampInactive() {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: "12:34:57")

        let expectedResult = LampState.off

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.secondsLamp)
    }

    @Test("when the hours are 0, the five hours lamps are OOOO")
    func getClockState_hoursZero_fiveHoursLampsInactive() {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: "00:00:00")

        let expectedResult: [LampState] = [.off, .off, .off, .off]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.fiveHoursRow)
    }
}
