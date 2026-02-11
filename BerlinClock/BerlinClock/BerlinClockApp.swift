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
            if isRunningUnitTests() {
                Text("Running Unit Tests...")
            } else {
                ClockView(
                    viewModel: DependencyInjectionContainer.clockViewModel
                )
            }
        }
    }

    private func isRunningUnitTests() -> Bool {
        return NSClassFromString("XCTestCase") != nil
    }
}
