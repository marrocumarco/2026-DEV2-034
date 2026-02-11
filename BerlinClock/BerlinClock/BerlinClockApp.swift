//
//  BerlinClockApp.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 08/02/2026.
//

import SwiftUI

@main
struct BerlinClockApp: App {
    var body: some Scene {
        WindowGroup {
            ClockView(
                viewModel: ClockViewModel(
                    clockUseCase: ClockUseCase(
                        timeProvider: TimeProvider(),
                        clockStateCalculator: ClockStateCalculator(dateParser: DateParserImpl())
                    )
                )
            )
        }
    }
}
