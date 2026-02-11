//
//  ClockViewState.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 11/02/2026
//

import SwiftUI

struct ClockViewState: Equatable {
    init(from presentationState: PresentationClockState) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        time = dateFormatter.string(from: presentationState.time)
        secondsLampColor = presentationState.state.secondsLamp == .yellow ? .yellow : .gray
    }

    let time: String
    let secondsLampColor: Color
}
