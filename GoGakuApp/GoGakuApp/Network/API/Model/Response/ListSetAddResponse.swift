//
//  ListSetAddResponse.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/19.
//

import Foundation

// MARK: - Welcome
struct ListSetAddResponse: JsonType {
    let data: ListSetAdd
}

// MARK: - DataClass
struct ListSetAdd: JsonType {
    let id: Int
    let title, image, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, title, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
