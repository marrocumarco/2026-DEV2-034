//
//  ClockStateCalculatorProtocol.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 10/02/2026
//

import Foundation

protocol ClockStateCalculatorProtocol {
    func getClockState(for time: Date) -> ClockState
}
