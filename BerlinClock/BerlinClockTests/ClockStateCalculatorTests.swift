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

    @Test("when the hours are between 0 and 4, the five hours lamps are OOOO", arguments: ["00:00:00", "01:00:00", "02:00:00", "03:00:00", "04:00:00"])
    func getClockState_hoursBetweenZeroAndFour_fiveHoursLampsInactive(timeString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let expectedResult: [LampState] = [.off, .off, .off, .off]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.fiveHoursRow)
    }

    @Test("when the hours are between 20 and 23, the five hours lamps are RRRR", arguments: ["20:00:00", "21:00:00", "22:00:00", "23:00:00"])
    func getClockState_hoursBetweenTwentyAndTwentythree_fiveHoursLampsActive(timeString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let expectedResult: [LampState] = [.red, .red, .red, .red]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.fiveHoursRow)
    }
}
