//
//  ClockStateCalculatorMock.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-034 on 10/02/2026
//

import Foundation
@testable import BerlinClock

class ClockStateCalculatorMock: ClockStateCalculatorProtocol {
    
    var getClockStateCalled = false
    var expectedClockState: ClockState!

    func getClockState(for time: Date) -> ClockState {
        getClockStateCalled = true
        return expectedClockState
    }
}
