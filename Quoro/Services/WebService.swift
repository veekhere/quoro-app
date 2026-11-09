//
//  WebService.swift
//  Quoro
//
//  Created by Vee K on 9/3/22.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The quotes URL is invalid."
        case .invalidResponse:
            return "The quotes server returned an unexpected response."
        case .decodingFailed:
            return "Could not decode the quotes response."
        }
    }
}

struct WebService {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func getQuotes(from url: URL) async throws -> [Quote] {
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }

        do {
            return try decoder.decode([Quote].self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
