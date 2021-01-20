//
//  ListWordUpdateResponse.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/19.
//

import Foundation

struct ListWordUpdateResponse: JsonType {
    let data: ListWordUpdate?
}

// MARK: - DataClass
struct ListWordUpdate: JsonType {
    let id: Int?
    let word, mean: String?
    let listSetsID: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, word, mean
        case listSetsID = "list_sets_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
