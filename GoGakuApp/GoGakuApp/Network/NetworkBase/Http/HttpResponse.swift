//
//  HttpResponse.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/17.
//

import Foundation

public protocol JsonType: Decodable {}
public enum HttpMethod: String {
    case get
    case post
    case put
    case delete
}

open class HttpResponse<BodyType> {

    public var status_code: Int
    public var headers: [String: String] = [:]
    public var body: BodyType

    init(status_code: Int, headers: [String: String], body: BodyType) {
        self.status_code = status_code
        self.headers = headers
        self.body = body
    }
}
