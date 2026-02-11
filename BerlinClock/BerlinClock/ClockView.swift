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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}
