//
//  ClockStateCalculator.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 08/02/2026
//

import Foundation

struct ClockStateCalculator {

    func getClockState(for time: Date) -> ClockState {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ss"
        let secondsString = dateFormatter.string(from: time)
        let seconds = Int(secondsString)!

        return ClockState(secondsLamp: calculateSecondsLampState(seconds: seconds))
    }

    private func calculateSecondsLampState(seconds: Int) -> LampState {
        return checkIsEven(seconds) ? .yellow : .off
    }

    private func checkIsEven(_ value: Int) -> Bool {
        return value.isMultiple(of: 2)
    }
}
