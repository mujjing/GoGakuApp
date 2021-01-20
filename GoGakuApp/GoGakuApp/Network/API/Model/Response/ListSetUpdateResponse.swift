//
//  ListSetUpdateResponse.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/19.
//

import Foundation

// MARK: - Welcome
struct ListSetUpdateResponse: JsonType {
    let data: ListSetUpdate?
}

// MARK: - DataClass
struct ListSetUpdate: JsonType {
    let id: Int?
    let title, image, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
