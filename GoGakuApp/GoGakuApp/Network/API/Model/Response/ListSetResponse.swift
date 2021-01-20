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
    let title, image, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, title, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

