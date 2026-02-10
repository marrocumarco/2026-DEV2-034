//
//  ClockViewModelTests.swift
//  BerlinClockTests
//
//  Created by 2026-DEV2-034 on 10/02/2026
//
	

import Foundation

class ClockUseCaseMock: ClockUseCaseProtocol {

}

struct ClockViewModelTests {
    let sut: ClockViewModel!
    let useCaseMock: ClockUseCaseMock!

    init() {
        useCaseMock = ClockUseCaseMock()
        sut = ClockViewModel(clockUseCase: useCaseMock)
    }
}
