//
//  HttpRequest.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/17.
//

import Foundation

open class HttpRequest<BodyType> {

    open var endPoint: String { fatalError("上書き必須") }
    open var headers: [String: String] { fatalError("上書き必須") }
    open var parameters: [String: Any] { fatalError("上書き必須") }
    open var method: HttpMethod { fatalError("上書き必須") }

    open var isJsonRequest: Bool {
        return headers["Content-Type"]?.lowercased().contains("application/json") ?? false
    }

    public init() {}
}
