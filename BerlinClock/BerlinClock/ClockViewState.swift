//
//  ClockViewState.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 11/02/2026
//

import SwiftUI

struct ClockViewState: Equatable {

    let time: String
    let secondsLampColor: Color
    let fiveHoursRow: [Color]
    let singleHoursRow: [Color]
    let fiveMinutesRow: [Color]
    let singleMinutesRow: [Color]

    static func create(from presentationState: PresentationClockState) -> ClockViewState {
        return ClockViewState(
            time: format(time: presentationState.time),
            secondsLampColor: calculateSecondsLampColor(presentationState),
            fiveHoursRow: calculateFiveHoursRowLampColors(from: presentationState),
            singleHoursRow: calculateSingleHoursRowLampColors(from: presentationState),
            fiveMinutesRow: calculateFiveMinutesRowLampColors(from: presentationState),
            singleMinutesRow: calculateSingleMinutesRowLampColors(from: presentationState),
        )
    }

    private static func format(time: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: time)
    }

    private static func calculateSecondsLampColor(_ presentationState: PresentationClockState) -> Color {
        return getColor(from: presentationState.state.secondsLamp)
    }

    private static func calculateFiveHoursRowLampColors(from presentationState: PresentationClockState) -> [Color] {
        return createColorList(from: presentationState.state.fiveHoursRow)
    }

    private static func calculateSingleHoursRowLampColors(from presentationState: PresentationClockState) -> [Color] {
        return createColorList(from: presentationState.state.singleHoursRow)
    }

    private static func calculateFiveMinutesRowLampColors(from presentationState: PresentationClockState) -> [Color] {
        return createColorList(from: presentationState.state.fiveMinutesRow)
    }

    private static func calculateSingleMinutesRowLampColors(from presentationState: PresentationClockState) -> [Color] {
        return createColorList(from: presentationState.state.singleMinutesRow)
    }

    private static func getColor(from state: LampState) -> Color {
        switch state {
        case .red:
            return .red
        case .yellow:
            return .yellow
        case .off:
            return .gray
        }
    }

    private static func createColorList(from lampStateList: [LampState]) -> [Color] {
        lampStateList.map { state in
            return getColor(from: state)
        }
    }
}
