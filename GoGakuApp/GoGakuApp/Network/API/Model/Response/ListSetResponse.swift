//
//  ListSetResponse.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/17.
//

import Foundation

// MARK: - Welcome
struct ListSetResponse: JsonType {
    let data: [ListSet]?
}

// MARK: - Datum
struct ListSet: JsonType {
    let id: Int
    let title, content, image, word: String
    let mean, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, title, content, image, word, mean
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
