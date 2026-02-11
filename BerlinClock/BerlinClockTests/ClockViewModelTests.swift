//
//  ClockViewModelTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-034 on 10/02/2026
//

import Foundation
import SwiftUI
import Testing

@testable import BerlinClock

class ClockUseCaseMock: ClockUseCaseProtocol {
    var continuation: AsyncStream<PresentationClockState>.Continuation?
    private var subscriptionContinuation: CheckedContinuation<Void, Never>?

    var getClockStateCalled = false

    func getClockState() -> AsyncStream<PresentationClockState> {
        if let subContinuation = subscriptionContinuation {
            getClockStateCalled = true

            subContinuation.resume()
            subscriptionContinuation = nil
        }
        return AsyncStream {
            continuation = $0
        }
    }

    func waitForSubscription() async {
        await withCheckedContinuation { continuation in
            self.subscriptionContinuation = continuation
        }
    }

    func emit(state: PresentationClockState) {
        continuation?.yield(state)
    }

    func finish() {
        continuation?.finish()
    }
}

struct ClockViewModelTests {
    let sut: ClockViewModel!
    let useCaseMock: ClockUseCaseMock!

    init() {
        useCaseMock = ClockUseCaseMock()
        sut = ClockViewModel(clockUseCase: useCaseMock)
    }

    @Test func `when startClock is called, the view model listens to the use case and sets the view state every time there is an update`() async {

        let presentationState = PresentationClockState(time: Date(timeIntervalSince1970: 0), state: .init(secondsLamp: .yellow, fiveHoursRow: [], singleHoursRow: [], fiveMinutesRow: [], singleMinutesRow: []))

        let expectedState = await ClockViewState(from: presentationState)

        let task = Task { await sut.startClock() }

        await useCaseMock.waitForSubscription()

        #expect(sut.uiState == nil)

        useCaseMock.emit(state: presentationState)

        try? await Task.sleep(nanoseconds: 10_000_000)

        #expect(useCaseMock.getClockStateCalled)
        #expect(sut.uiState == expectedState)

        useCaseMock.finish()
        await task.value
    }
}
