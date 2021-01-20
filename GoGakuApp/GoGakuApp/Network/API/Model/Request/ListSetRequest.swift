//
//  ListSetRequest.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/17.
//

import Foundation

final class ListSetRequest: GoGakuHttpRequest<ListSetResponse> {

    override var method: HttpMethod {
        return .get
    }

    override var path: String {
        return "/api/listset"
    }

    override var query: [String: Any] {
        return [
            "":""
        ]
    }

}
