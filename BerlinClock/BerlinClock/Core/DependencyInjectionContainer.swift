//
//  DependencyInjectionContainer.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 11/02/2026
//

import Foundation

struct DependencyInjectionContainer {
    static var clockViewModel: ClockViewModel {
        ClockViewModel(
            clockUseCase: ClockUseCase(
                timeProvider: TimeProvider(),
                clockStateCalculator: ClockStateCalculator(dateParser: DateParserImpl())
            )
        )
    }
}
