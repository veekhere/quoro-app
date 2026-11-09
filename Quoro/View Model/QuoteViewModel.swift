//
//  QuoteViewModel.swift
//  Quoro
//
//  Created by Vee K on 9/3/22.
//

import Foundation
import Observation

@Observable
@MainActor
final class QuotesViewModel {
    private(set) var quote = QuoteDisplay(text: "", author: "Quoro")
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    private var cachedQuotes: [Quote] = []
    private let webService = WebService()

    func giveMeAQuote() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            if cachedQuotes.isEmpty {
                cachedQuotes = try await webService.getQuotes(from: Constants.URLs.quotes)
            }

            guard let next = cachedQuotes.randomElement() else {
                errorMessage = "No quotes available."
                return
            }

            quote = QuoteDisplay(quote: next)
        } catch {
            errorMessage = "Couldn't load quotes. Check your connection."
        }
    }
}

struct QuoteDisplay: Equatable, Sendable {
    let text: String
    let author: String

    init(text: String, author: String) {
        self.text = text
        self.author = author
    }

    init(quote: Quote) {
        text = quote.text
        author = quote.author?.trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty ?? "Unknown"
    }
}

private extension String {
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}
