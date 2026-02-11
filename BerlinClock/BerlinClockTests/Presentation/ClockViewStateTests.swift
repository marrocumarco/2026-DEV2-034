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

    @Test func `all rows have colors matching to the state`() throws {

        let sut = ClockViewState.create(from: PresentationClockState(time: Date(timeIntervalSince1970: 0), state: ClockState(
            secondsLamp: .yellow,
            fiveHoursRow: [.red, .red, .red, .off],
            singleHoursRow: [.red, .red, .off, .off],
            fiveMinutesRow: [.yellow, .yellow, .red, .off, .off, .off, .off, .off, .off, .off, .off],
            singleMinutesRow: [.yellow, .yellow, .off, .off]
        )))

        #expect(sut.fiveHoursRow == [Color.red, Color.red, Color.red, Color.gray])
        #expect(sut.singleHoursRow == [Color.red, Color.red, Color.gray, Color.gray])
        let expectedFiveMinutesRow = [Color.yellow, Color.yellow, Color.red, Color.gray, Color.gray, Color.gray, Color.gray, Color.gray, Color.gray, Color.gray, Color.gray]
        #expect(expectedFiveMinutesRow.count == sut.fiveMinutesRow.count)

        for index in 0..<expectedFiveMinutesRow.count {
            #expect(sut.fiveMinutesRow[index] == expectedFiveMinutesRow[index])
        }

        #expect(sut.singleMinutesRow == [Color.yellow, Color.yellow, Color.gray, Color.gray])
    }

    @Test(arguments: [
        (
            ClockState(
                    secondsLamp: .yellow,
                    fiveHoursRow: [.red, .red, .red, .off],
                    singleHoursRow: [.red, .red, .off, .off],
                    fiveMinutesRow: [.yellow, .yellow, .red, .off, .off, .off, .off, .off, .off, .off, .off],
                    singleMinutesRow: [.yellow, .yellow, .off, .off]
                )
            ,
            ClockViewState(
                time: Date(timeIntervalSince1970: 0).formatted(.dateTime.hour().minute().second()),
                secondsLampColor: .yellow,
                fiveHoursRow: [Color.red, Color.red, Color.red, Color.gray],
                singleHoursRow: [Color.red, Color.red, Color.gray, Color.gray],
                fiveMinutesRow: [
                    Color.yellow, Color.yellow, Color.red, Color.gray, Color.gray, Color.gray, Color.gray, Color.gray,
                    Color.gray, Color.gray, Color.gray,
                ],
                singleMinutesRow: [Color.yellow, Color.yellow, Color.gray, Color.gray]
            )
        ),
        (
            ClockState(
                    secondsLamp: .off,
                    fiveHoursRow: [.red, .red, .off, .off],
                    singleHoursRow: [.red, .red, .red, .off],
                    fiveMinutesRow: [.yellow, .yellow, .red, .yellow, .off, .off, .off, .off, .off, .off, .off],
                    singleMinutesRow: [.yellow, .yellow, .yellow, .off]
                )
            ,
            ClockViewState(
                time: Date(timeIntervalSince1970: 1).formatted(.dateTime.hour().minute().second()),
                secondsLampColor: .gray,
                fiveHoursRow: [Color.red, Color.red, Color.gray, Color.gray],
                singleHoursRow: [Color.red, Color.red, Color.red, Color.gray],
                fiveMinutesRow: [
                    Color.yellow, Color.yellow, Color.red, Color.yellow, Color.gray, Color.gray, Color.gray, Color.gray,
                    Color.gray, Color.gray, Color.gray,
                ],
                singleMinutesRow: [Color.yellow, Color.yellow, Color.yellow, Color.gray]
            )
        )
    ])
    func `test if colors match with clock state`(clockState: ClockState, expectedViewState: ClockViewState) {

        let presentationClockState = PresentationClockState(time: Date(), state: clockState)

        let sut = ClockViewState.create(from: presentationClockState)

        #expect(sut.secondsLampColor == expectedViewState.secondsLampColor)
        #expect(sut.fiveHoursRow == expectedViewState.fiveHoursRow)
        #expect(sut.singleHoursRow == expectedViewState.singleHoursRow)
        #expect(sut.fiveMinutesRow == expectedViewState.fiveMinutesRow)
        #expect(sut.singleMinutesRow == expectedViewState.singleMinutesRow)
    }
}
