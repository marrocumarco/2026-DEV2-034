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
            fiveHoursRow: [Color.red, Color.red, Color.red, Color.gray],
            singleHoursRow: [Color.red, Color.red, Color.gray, Color.gray],
            fiveMinutesRow: [
                Color.yellow, Color.yellow, Color.red, Color.gray, Color.gray, Color.gray, Color.gray, Color.gray,
                Color.gray, Color.gray, Color.gray
            ],
            singleMinutesRow: [Color.yellow, Color.yellow, Color.gray, Color.gray]
        )
    }

    private static func format(time: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: time)
    }

    private static func calculateSecondsLampColor(_ presentationState: PresentationClockState) -> Color {
        return presentationState.state.secondsLamp == .yellow ? .yellow : .gray
    }
}
