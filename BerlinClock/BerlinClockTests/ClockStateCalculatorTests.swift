//
//  ClockStateCalculatorTests.swift
//  ClockStateCalculatorTests
//
//  Created by 2026-DEV2-034 on 08/02/2026.
//

import Testing
import Foundation
@testable import BerlinClock

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
    }
}
