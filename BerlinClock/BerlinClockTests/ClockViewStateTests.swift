//
//  ClockViewStateTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-034 on 11/02/2026
//
	

import Foundation
import Testing

@testable import BerlinClock

struct ClockViewStateTests {

    @Test func `seconds lamp color is correct`() throws {

        let sut = ClockViewState(from: PresentationClockState(time: Date(timeIntervalSince1970: 0), state: ClockState(secondsLamp: .yellow, fiveHoursRow: [], singleHoursRow: [], fiveMinutesRow: [], singleMinutesRow: [])))

        #expect(sut.secondsLampColor == Color.yellow)
    }
}
