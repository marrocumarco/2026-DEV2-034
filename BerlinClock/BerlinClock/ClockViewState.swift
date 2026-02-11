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

    static func create(from presentationState: PresentationClockState) -> ClockViewState {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return ClockViewState(
            time: dateFormatter.string(from: presentationState.time),
            secondsLampColor: presentationState.state.secondsLamp == .yellow ? .yellow : .gray
        )
    }
}
