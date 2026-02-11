//
//  ClockView.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 08/02/2026.
//

import SwiftUI

struct ClockView: View {
    @State var viewModel: ClockViewModel
    var body: some View {
        VStack {
            if let uiState = viewModel.uiState {
                Circle()
                    .fill(uiState.secondsLampColor)
                ClockViewRow(colors: uiState.fiveHoursRow)
                ClockViewRow(colors: uiState.singleHoursRow)
                ClockViewRow(colors: uiState.fiveMinutesRow)
                ClockViewRow(colors: uiState.singleMinutesRow)
                Text(uiState.time).font(.headline)
            }
        }
        .padding()
        .task { await viewModel.startClock() }
    }
}

struct ClockViewRow: View {
    let colors: [Color]
    var body: some View {
        HStack {
            ForEach(colors, id: \.hashValue) { color in
                Rectangle()
                    .fill(color)
            }
        }
    }
}
