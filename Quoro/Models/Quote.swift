//
//  Quote.swift
//  Quoro
//
//  Created by Vee K on 9/3/22.
//

import Foundation

struct Quote: Decodable, Sendable, Equatable {
    let text: String
    let author: String?

    enum CodingKeys: String, CodingKey {
        case text = "q"
        case author = "a"
    }
}
