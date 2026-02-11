//
//  ClockViewState.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 11/02/2026
//

import SwiftUI

struct ClockViewState: Equatable {
    init(from presentationState: PresentationClockState) {
        secondsLampColor = presentationState.state.secondsLamp == .yellow ? .yellow : .gray
    }

    let secondsLampColor: Color
}
