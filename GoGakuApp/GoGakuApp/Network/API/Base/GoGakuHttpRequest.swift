//
//  GoGakuHttpRequest.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/17.
//

import Foundation

class GoGakuHttpRequest<Body: JsonType>: HttpRequest<Body> {

    override var endPoint: String {
        print("url : http://\(domain)\(path)")
        return "http://\(domain)\(path)"
    }

    override var headers: [String: String] {
        return [:]
    }

    override var parameters: [String: Any] {
        return [:]
    }

    var domain: String {
        return GoGakuAPIConfig.domain
    }

    var path: String { fatalError("上書き必須") }

    var query: [String: Any] {
        return [:]
    }

    fileprivate var queryString : String {
        var queryString: String = .empty
        for key in query.keys {
            let queryParam = "\(key)=\(query[key] ?? String.empty)"
            switch queryString {
                case .empty:
                    queryString += "?\(queryParam)"
                break
                default:
                    queryString += "&\(queryParam)"
                break
            }
        }
        return queryString
    }

}

