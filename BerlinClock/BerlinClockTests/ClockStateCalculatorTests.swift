//
//  ClockStateCalculatorTests.swift
//  ClockStateCalculatorTests
//
//  Created by 2026-DEV2-034 on 08/02/2026.
//

import Foundation
import Testing

@testable import BerlinClock

@MainActor
struct ClockStateCalculatorTests {

    var sut: ClockStateCalculator!

    init() {
        sut = ClockStateCalculator()
    }

    @Test(
        "when the seconds are even, the seconds lamp is active and yellow, when the seconds are odd, the seconds lamp is inactive",
        arguments: [("12:34:56", LampState.yellow), ("12:34:57", LampState.off)]
    )
    func getClockState_secondsEven_secondsLampActiveYellow(timeString: String, expectedResult: LampState) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.secondsLamp)

    }

    @Test(
        """
        when the hours are between 0 and 4, the five hours lamps are OOOO,
        when the hours are between 5 and 9, the five hours lamps are ROOO,
        when the hours are between 10 and 14, the five hours lamps are RROO,
        when the hours are between 15 and 19, the five hours lamps are RRRO,
        when the hours are between 20 and 24, the five hours lamps are RRRR
        """,
        arguments: [
            ("00:00:00", [LampState.off, LampState.off, LampState.off, LampState.off]),
            ("01:00:00", [LampState.off, LampState.off, LampState.off, LampState.off]),
            ("02:00:00", [LampState.off, LampState.off, LampState.off, LampState.off]),
            ("03:00:00", [LampState.off, LampState.off, LampState.off, LampState.off]),
            ("04:00:00", [LampState.off, LampState.off, LampState.off, LampState.off]),

            ("05:00:00", [LampState.red, LampState.off, LampState.off, LampState.off]),
            ("06:00:00", [LampState.red, LampState.off, LampState.off, LampState.off]),
            ("07:00:00", [LampState.red, LampState.off, LampState.off, LampState.off]),
            ("08:00:00", [LampState.red, LampState.off, LampState.off, LampState.off]),
            ("09:00:00", [LampState.red, LampState.off, LampState.off, LampState.off]),

            ("10:00:00", [LampState.red, LampState.red, LampState.off, LampState.off]),
            ("11:00:00", [LampState.red, LampState.red, LampState.off, LampState.off]),
            ("12:00:00", [LampState.red, LampState.red, LampState.off, LampState.off]),
            ("13:00:00", [LampState.red, LampState.red, LampState.off, LampState.off]),
            ("14:00:00", [LampState.red, LampState.red, LampState.off, LampState.off]),

            ("15:00:00", [LampState.red, LampState.red, LampState.red, LampState.off]),
            ("16:00:00", [LampState.red, LampState.red, LampState.red, LampState.off]),
            ("17:00:00", [LampState.red, LampState.red, LampState.red, LampState.off]),
            ("18:00:00", [LampState.red, LampState.red, LampState.red, LampState.off]),
            ("19:00:00", [LampState.red, LampState.red, LampState.red, LampState.off]),

            ("20:00:00", [LampState.red, LampState.red, LampState.red, LampState.red]),
            ("21:00:00", [LampState.red, LampState.red, LampState.red, LampState.red]),
            ("22:00:00", [LampState.red, LampState.red, LampState.red, LampState.red]),
            ("23:00:00", [LampState.red, LampState.red, LampState.red, LampState.red]),
        ]
    )
    func getClockState_fiveHoursLamps(timeString: String, expectedResult: [LampState]) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.fiveHoursRow)
    }

    @Test(
        """
        when the hours are 0, the single hours lamps are OOOO,
        when the hours end with 1 or 6, the single hours row is ROOO,
        when the hours end with 2 or 7, the single hours row is RROO,
        when the hours end with 3 or 8, the single hours row is RRRO,
        when the hours end with 4 or 9, the single hours row is RRRR
        """,
        arguments: [
            ("00:00:00", [LampState.off, LampState.off, LampState.off, LampState.off]),

            ("01:00:00", [LampState.red, LampState.off, LampState.off, LampState.off]),
            ("16:00:00", [LampState.red, LampState.off, LampState.off, LampState.off]),

            ("22:00:00", [LampState.red, LampState.red, LampState.off, LampState.off]),
            ("07:00:00", [LampState.red, LampState.red, LampState.off, LampState.off]),

            ("23:00:00", [LampState.red, LampState.red, LampState.red, LampState.off]),
            ("08:00:00", [LampState.red, LampState.red, LampState.red, LampState.off]),

            ("14:00:00", [LampState.red, LampState.red, LampState.red, LampState.red]),
            ("09:00:00", [LampState.red, LampState.red, LampState.red, LampState.red]),
        ]
    )
    func getClockState_SingleHoursRow(timeString: String, expectedResult: [LampState]) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.singleHoursRow)
    }

    @Test(
        """
        when the minutes are between 0 and 4, the five minutes row is OOOOOOOOOOO,
        when the minutes are between 55 and 59, the five minutes row is YYRYYRYYRYY,
        when the minutes are between 20 and 24, the five minutes row is YYRYOOOOOOO
        when the minutes are between 35 and 39, the five minutes row is YYRYYRYOOOO
        """,
        arguments: [
            (
                "00:00:00",
                [
                    LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off,
                    LampState.off, LampState.off, LampState.off, LampState.off, LampState.off,
                ]
            ),
            (
                "00:01:00",
                [
                    LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off,
                    LampState.off, LampState.off, LampState.off, LampState.off, LampState.off,
                ]
            ),
            (
                "00:02:00",
                [
                    LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off,
                    LampState.off, LampState.off, LampState.off, LampState.off, LampState.off,
                ]
            ),
            (
                "00:03:00",
                [
                    LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off,
                    LampState.off, LampState.off, LampState.off, LampState.off, LampState.off,
                ]
            ),
            (
                "00:04:00",
                [
                    LampState.off, LampState.off, LampState.off, LampState.off, LampState.off, LampState.off,
                    LampState.off, LampState.off, LampState.off, LampState.off, LampState.off,
                ]
            ),
            (
                "23:55:59",
                [
                    LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow,
                    LampState.red, LampState.yellow, LampState.yellow, LampState.red, LampState.yellow,
                    LampState.yellow,
                ]
            ),
            (
                "23:57:59",
                [
                    LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow,
                    LampState.red, LampState.yellow, LampState.yellow, LampState.red, LampState.yellow,
                    LampState.yellow,
                ]
            ),
            (
                "23:59:59",
                [
                    LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow,
                    LampState.red, LampState.yellow, LampState.yellow, LampState.red, LampState.yellow,
                    LampState.yellow,
                ]
            ),
            (
                "12:20:00",
                [
                    LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.off, LampState.off,
                    LampState.off, LampState.off, LampState.off, LampState.off, LampState.off,
                ]
            ),
            (
                "12:23:00",
                [
                    LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.off, LampState.off,
                    LampState.off, LampState.off, LampState.off, LampState.off, LampState.off,
                ]
            ),
            (
                "12:35:00",
                [
                    LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow,
                    LampState.red, LampState.yellow, LampState.off, LampState.off, LampState.off, LampState.off,
                ]
            ),
            (
                "12:39:00",
                [
                    LampState.yellow, LampState.yellow, LampState.red, LampState.yellow, LampState.yellow,
                    LampState.red, LampState.yellow, LampState.off, LampState.off, LampState.off, LampState.off,
                ]
            ),
        ]
    )

    func getClockState_FiveMinutesRow(timeString: String, expectedResult: [LampState]) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.fiveMinutesRow)
    }

    @Test("when the minutes are multiple of 5, the single minutes row is OOOO", arguments: ["00:00:00", "12:35:00"])
    func getClockState_minutesMultipleOfFive_SingleMinutesRow_AllInactive(minutesString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: minutesString)

        let expectedResult: [LampState] = [.off, .off, .off, .off]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.singleMinutesRow)
    }

    @Test(
        "when the minutes' last digit is 4 or 9, the single minutes row is YYYY",
        arguments: ["23:59:59", "12:34:00"]
    )
    func getClockState_minutesLastDigitIsFourOrNine_SingleMinutesRow_AllActive(minutesString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: minutesString)

        let expectedResult: [LampState] = [.yellow, .yellow, .yellow, .yellow]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.singleMinutesRow)
    }

    @Test(
        "when the minutes' last digit is 1 or 6, the single minutes row is YOOO",
        arguments: ["23:51:59", "12:36:00"]
    )
    func getClockState_minutesLastDigitIsOneOrSix_SingleMinutesRow_OneActive(minutesString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: minutesString)

        let expectedResult: [LampState] = [.yellow, .off, .off, .off]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.singleMinutesRow)
    }

    @Test(
        "when the minutes' last digit is 2 or 7, the single minutes row is YYOO",
        arguments: ["23:52:59", "12:37:00"]
    )
    func getClockState_minutesLastDigitIsTwoOrSeven_SingleMinutesRow_TwoActive(minutesString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: minutesString)

        let expectedResult: [LampState] = [.yellow, .yellow, .off, .off]

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expectedResult == clockState.singleMinutesRow)
    }

    @Test(
        "test the entire clock",
        arguments: [
            (
                "00:00:00",
                ClockState(
                    secondsLamp: .yellow,
                    fiveHoursRow: [.off, .off, .off, .off],
                    singleHoursRow: [.off, .off, .off, .off],
                    fiveMinutesRow: [.off, .off, .off, .off, .off, .off, .off, .off, .off, .off, .off],
                    singleMinutesRow: [.off, .off, .off, .off]
                )
            ),
            (
                "23:59:59",
                ClockState(
                    secondsLamp: .off,
                    fiveHoursRow: [.red, .red, .red, .red],
                    singleHoursRow: [.red, .red, .red, .off],
                    fiveMinutesRow: [
                        .yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow,
                    ],
                    singleMinutesRow: [.yellow, .yellow, .yellow, .yellow]
                )
            ),
            (
                "16:50:06",
                ClockState(
                    secondsLamp: .yellow,
                    fiveHoursRow: [.red, .red, .red, .off],
                    singleHoursRow: [.red, .off, .off, .off],
                    fiveMinutesRow: [
                        .yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .off,
                    ],
                    singleMinutesRow: [.off, .off, .off, .off]
                )
            ),
            (
                "11:37:01",
                ClockState(
                    secondsLamp: .off,
                    fiveHoursRow: [.red, .red, .off, .off],
                    singleHoursRow: [.red, .off, .off, .off],
                    fiveMinutesRow: [.yellow, .yellow, .red, .yellow, .yellow, .red, .yellow, .off, .off, .off, .off],
                    singleMinutesRow: [.yellow, .yellow, .off, .off]
                )
            ),
        ]
    )
    func getClockState_ZeroTime(timeString: String, expected: ClockState) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        let time = dateFormatter.date(from: timeString)

        let clockState: ClockState = sut.getClockState(for: time!)

        #expect(expected == clockState)
    }
}
