//
//  ListWordGetRequest.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/19.
//

import Foundation

final class ListWordGetRequest: GoGakuHttpRequest<ListWordGetResponse> {

    override var method: HttpMethod {
        return .get
    }

    override var path: String {
        return "/api/listget/\(id.listID)"
    }
    var id = IDDelivery.shared

    override var query: [String: Any] {
        return [
            "":""
        ]
    }

}
