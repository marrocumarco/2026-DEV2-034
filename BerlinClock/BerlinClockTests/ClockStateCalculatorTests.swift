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

    @Test("when the hours are between 5 and 9, the five hours lamps are ROOO", arguments: ["05:00:00", "06:00:00", "07:00:00", "08:00:00", "09:00:00"])
    func getClockState_hoursBetweenFiveAndNine_fiveHoursLamps_OneActive(timeString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let expectedResult: [LampState] = [.red, .off, .off, .off]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.fiveHoursRow)
    }

    @Test("when the hours are between 10 and 14, the five hours lamps are RROO", arguments: ["10:00:00", "11:00:00", "12:00:00", "13:00:00", "14:00:00"])
    func getClockState_hoursBetweenTenAndFourteen_fiveHoursLamps_TwoActive(timeString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let expectedResult: [LampState] = [.red, .red, .off, .off]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.fiveHoursRow)
    }

    @Test("when the hours are between 15 and 19, the five hours lamps are RRRO", arguments: ["15:00:00", "16:00:00", "17:00:00", "18:00:00", "19:00:00"])
    func getClockState_hoursBetweenFifteenAndNineteen_fiveHoursLamps_ThreeActive(timeString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let expectedResult: [LampState] = [.red, .red, .red, .off]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.fiveHoursRow)
    }

    @Test("when the hours are 0, the single hours lamps are OOOO")
    func getClockState_hoursZero_SingleHoursRow_AllInactive() {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: "00:00:00")

        let expectedResult: [LampState] = [.off, .off, .off, .off]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.singleHoursRow)
    }

    @Test("when the hours end with 1 or 6, the single hours row is ROOO", arguments: ["01:00:00", "16:00:00"])
    func getClockState_hoursEndWithOneOrSix_SingleHoursRow_OneActiveLamp(timeString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let expectedResult: [LampState] = [.red, .off, .off, .off]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.singleHoursRow)
    }

    @Test("when the hours end with 2 or 7, the single hours row is RROO", arguments: ["22:00:00", "07:00:00"])
    func getClockState_hoursEndWithTwoOrSeven_SingleHoursRow_TwoActiveLamps(timeString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let expectedResult: [LampState] = [.red, .red, .off, .off]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.singleHoursRow)
    }

    @Test("when the hours end with 3 or 8, the single hours row is RRRO", arguments: ["23:00:00", "08:00:00"])
    func getClockState_hoursEndWithThreeOrEight_SingleHoursRow_ThreeActiveLamps(timeString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let expectedResult: [LampState] = [.red, .red, .red, .off]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.singleHoursRow)
    }

    @Test("when the hours end with 4 or 9, the single hours row is RRRR", arguments: ["14:00:00", "09:00:00"])
    func getClockState_hoursEndWithFourOrNine_SingleHoursRow_AllActiveLamps(timeString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let expectedResult: [LampState] = [.red, .red, .red, .red]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.singleHoursRow)
    }

    @Test("when the minutes are between 0 and 4, the five minutes row is OOOOOOOOOOO", arguments: ["00:00:00", "00:01:00", "00:02:00", "00:03:00", "00:04:00"])
    func getClockState_minutesBetweenZeroAndFour_FiveMinutesRow_AllInactive(timeString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let expectedResult: [LampState] = [.off, .off, .off, .off, .off, .off, .off, .off, .off, .off, .off]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.fiveMinutesRow)
    }

    @Test("when the minutes are between 55 and 59, the five minutes row is YYRYYRYYRYY", arguments: ["23:55:59", "23:57:59", "23:59:59"])
    func getClockState_minutesBetweenFiftyFiveAndFiftyNine_FiveMinutesRow_AllActive(timeString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let expectedResult: [LampState] = [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.fiveMinutesRow)
    }

    @Test("when the minutes are between 20 and 24, the five minutes row is YYRYOOOOOOO", arguments: ["12:20:00", "12:23:00"])
    func getClockState_minutesBetweenTwentyAndTwentyFour_FiveMinutesRow_FourActive(timeString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let expectedResult: [LampState] = [.yellow, .yellow, .red, .yellow, .off, .off, .off, .off, .off, .off, .off]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.fiveMinutesRow)
    }

    @Test("when the minutes are between 35 and 39, the five minutes row is YYRYYRYOOOO", arguments: ["12:35:00", "12:39:00"])
    func getClockState_minutesBetweenThirtyfiveAndThirtyNine_FiveMinutesRow_SevenActive(timeString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let expectedResult: [LampState] = [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .off, .off, .off, .off]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.fiveMinutesRow)
    }
}
