//
//  ClockStateCalculator.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 08/02/2026
//

import Foundation

struct ClockStateCalculator: ClockStateCalculatorProtocol {

    private static let hoursPerLampInFiveHoursRow = 5
    private static let minutesPerLampInFiveMinutesRow = 5
    private static let redLampsIntervalInFiveMinutesRow = 3
    private static let singleHoursRowModulus = 5
    private static let singleMinutesRowModulus = 5

    private let dateParser: DateParser

    init(dateParser: any DateParser) {
        self.dateParser = dateParser
    }

    func getClockState(for time: Date) -> ClockState {

        let seconds = dateParser.parseSeconds(from: time)
        let minutes = dateParser.parseMinutes(from: time)
        let hours = dateParser.parseHours(from: time)

        return ClockState(
            secondsLamp: calculateSecondsLampState(seconds: seconds),
            fiveHoursRow: calculateFiveHoursRow(hours: hours),
            singleHoursRow: calculateSingleHoursRow(hours: hours),
            fiveMinutesRow: calculateFiveMinutesRow(minutes: minutes),
            singleMinutesRow: calculateSingleMinutesRow(minutes: minutes)
        )
    }

    private func calculateSecondsLampState(seconds: Int) -> LampState {
        return checkIsEven(seconds) ? .yellow : .off
    }

    private func checkIsEven(_ value: Int) -> Bool {
        return value.isMultiple(of: 2)
    }

    private func calculateFiveHoursRow(hours: Int) -> [LampState] {
        var fiveHoursRow: [LampState] = [.off, .off, .off, .off]
        for index in 0..<getNumberOfActiveLampsInFiveHoursRow(for: hours) {
            fiveHoursRow[index] = .red
        }
        return fiveHoursRow
    }

    private func getNumberOfActiveLampsInFiveHoursRow(for hours: Int) -> Int {
        hours / Self.hoursPerLampInFiveHoursRow
    }

    private func calculateSingleHoursRow(hours: Int) -> [LampState] {
        var singleHoursRow: [LampState] = [.off, .off, .off, .off]
        for index in 0..<getNumberOfActiveLampsInSingleHoursRow(for: hours) {
            singleHoursRow[index] = .red
        }
        return singleHoursRow
    }

    private func getNumberOfActiveLampsInSingleHoursRow(for hours: Int) -> Int {
        hours % Self.singleHoursRowModulus
    }

    private func calculateFiveMinutesRow(minutes: Int) -> [LampState] {
        var fiveMinutesRow: [LampState] = [.off, .off, .off, .off, .off, .off, .off, .off, .off, .off, .off]

        for index in 0..<getNumberOfActiveLampsInFiveMinutesRow(for: minutes) {
            fiveMinutesRow[index] = getFiveMinutesRowLampColor(index)
        }

        return fiveMinutesRow
    }

    private func getNumberOfActiveLampsInFiveMinutesRow(for minutes: Int) -> Int {
        minutes / Self.minutesPerLampInFiveMinutesRow
    }

    private func getFiveMinutesRowLampColor(_ index: Int) -> LampState {
        if (index + 1).isMultiple(of: Self.redLampsIntervalInFiveMinutesRow) {
            return .red
        } else {
            return .yellow
        }
    }

    private func calculateSingleMinutesRow(minutes: Int) -> [LampState] {
        var singleMinutesRow: [LampState] = [.off, .off, .off, .off]

        for index in 0..<getNumberOfActiveLampsInSingleMinutesRow(for: minutes) {
            singleMinutesRow[index] = .yellow
        }

        return singleMinutesRow
    }

    private func getNumberOfActiveLampsInSingleMinutesRow(for minutes: Int) -> Int {
        minutes % Self.singleMinutesRowModulus
    }
}
