//
//  ContentView.swift
//  Quoro
//
//  Created by Vee K on 9/3/22.
//

import SwiftUI

struct ContentView: View {
    var viewModel: QuotesViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                if viewModel.isLoading && viewModel.quote.text.isEmpty {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text(viewModel.quote.text)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, minHeight: 130, alignment: .topLeading)
                }
            }
            .padding(12)

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(.red)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 8)
            }

            Divider()
                .padding(.bottom, 5)

            HStack {
                Text("© \(viewModel.quote.author)")
                    .fontWeight(.thin)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .bottom], 12)

                Spacer()

                Menu {
                    Button("Next quote") {
                        Task {
                            await viewModel.giveMeAQuote()
                        }
                    }
                    Divider()
                    Button("Quit Quoro") {
                        NSApplication.shared.terminate(nil)
                    }
                } label: {
                    Label("Menu", systemImage: "ellipsis.circle")
                }
                .menuStyle(.borderlessButton)
                .frame(width: 100)
                .padding([.bottom, .trailing], 12)
            }
        }
        .frame(width: 320)
        .task {
            await viewModel.giveMeAQuote()
        }
    }
}

#Preview {
    ContentView(viewModel: QuotesViewModel())
        .frame(width: 320, height: 200)
}
