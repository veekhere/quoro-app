//
//  QuoroApp.swift
//  Quoro
//
//  Created by Vee K on 9/3/22.
//

import SwiftUI

@main
struct QuoroApp: App {
    @State private var viewModel = QuotesViewModel()

    var body: some Scene {
        MenuBarExtra("Quoro", systemImage: "quote.bubble") {
            ContentView(viewModel: viewModel)
        }
        .menuBarExtraStyle(.window)
    }
}
