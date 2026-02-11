//
//  ClockViewModel.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 10/02/2026
//

import Foundation

@Observable
class ClockViewModel {
    internal init(clockUseCase: any ClockUseCaseProtocol) {
        self.clockUseCase = clockUseCase
    }

    private(set) var uiState: ClockViewState?
    private let clockUseCase: ClockUseCaseProtocol

    func startClock() async {
        for await state in clockUseCase.getClockState() {
            updateViewState(state)
        }
    }

    fileprivate func updateViewState(_ state: PresentationClockState) {
        uiState = ClockViewState.create(from: state)
    }
}
