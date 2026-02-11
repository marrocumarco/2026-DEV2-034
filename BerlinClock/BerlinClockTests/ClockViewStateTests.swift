//
//  ClockViewStateTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-034 on 11/02/2026
//
	

import Foundation
import Testing
import SwiftUI

@testable import BerlinClock

struct ClockViewStateTests {

    @Test(arguments: ["00:00:00", "23:59:59"])
    func `the timestamp corresponds to the formatted time of the state`(expectedTimeString: String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let time = dateFormatter.date(from: expectedTimeString)!

        let sut = ClockViewState.create(from: PresentationClockState(time: time, state: ClockState(secondsLamp: .yellow, fiveHoursRow: [], singleHoursRow: [], fiveMinutesRow: [], singleMinutesRow: [])))

        #expect(expectedTimeString == sut.time)
    }

    @Test func `seconds lamp color is yellow when on`() throws {

        let sut = ClockViewState.create(from: PresentationClockState(time: Date(timeIntervalSince1970: 0), state: ClockState(secondsLamp: .yellow, fiveHoursRow: [], singleHoursRow: [], fiveMinutesRow: [], singleMinutesRow: [])))

        #expect(sut.secondsLampColor == Color.yellow)
    }

    @Test func `seconds lamp color is gray when off`() throws {

        let sut = ClockViewState.create(from: PresentationClockState(time: Date(timeIntervalSince1970: 0), state: ClockState(secondsLamp: .off, fiveHoursRow: [], singleHoursRow: [], fiveMinutesRow: [], singleMinutesRow: [])))

        #expect(sut.secondsLampColor == Color.gray)
    }

    @Test func `five hours row colors correspond to the state`() throws {

        let sut = ClockViewState.create(from: PresentationClockState(time: Date(timeIntervalSince1970: 0), state: ClockState(
            secondsLamp: .yellow,
            fiveHoursRow: [.red, .off, .red, .off],
            singleHoursRow: [.off, .off, .off, .off],
            fiveMinutesRow: [.off, .off, .off, .off, .off, .off, .off, .off, .off, .off, .off],
            singleMinutesRow: [.off, .off, .off, .off]
        )))

        #expect(sut.fiveHoursRow == [Color.red, Color.gray, Color.red, Color.gray])
    }
}
