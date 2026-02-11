//
//  TimeProvider.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 11/02/2026
//

import Foundation

class TimeProvider: TimeProviderProtocol {
    func getTime() -> AsyncStream<Date> {
        AsyncStream { continuation in
            let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                continuation.yield(Date())
            }
        }
    }
}
