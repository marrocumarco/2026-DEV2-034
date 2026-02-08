//
//  ClockStateCalculator.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 08/02/2026
//

import Foundation

struct ClockStateCalculator {

    private static let hoursPerLampInFiveHoursRow = 5

    func getClockState(for time: Date) -> ClockState {

        let seconds = parseSeconds(from: time)
        let hours = parseHours(from: time)

        return ClockState(
            secondsLamp: calculateSecondsLampState(seconds: seconds),
            fiveHoursRow: calculateFiveHoursRow(hours: hours),
            singleHoursRow: calculateSingleHoursRow(hours: hours)
        )
    }

    private func parseSeconds(from time: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ss"
        let secondsString = dateFormatter.string(from: time)
        return Int(secondsString)!
    }

    private func parseHours(from time: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let hoursString = dateFormatter.string(from: time)
        return Int(hoursString)!
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
        hours % 5
    }
}
