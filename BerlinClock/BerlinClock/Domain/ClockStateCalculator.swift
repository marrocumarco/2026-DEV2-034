//
//  ClockStateCalculator.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 08/02/2026
//

import Foundation

struct ClockStateCalculator {

    func getClockState(for time: Date) -> ClockState {

        let seconds = parseSeconds(from: time)
        return ClockState(
            secondsLamp: calculateSecondsLampState(seconds: seconds),
            fiveHoursRow: [.off, .off, .off, .off]
        )
    }

    private func parseSeconds(from time: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ss"
        let secondsString = dateFormatter.string(from: time)
        return Int(secondsString)!
    }

    private func calculateSecondsLampState(seconds: Int) -> LampState {
        return checkIsEven(seconds) ? .yellow : .off
    }

    private func checkIsEven(_ value: Int) -> Bool {
        return value.isMultiple(of: 2)
    }
}
