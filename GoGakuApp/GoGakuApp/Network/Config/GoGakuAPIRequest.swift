//
//  GoGakuAPIRequest.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/20.
//

import Foundation
import Alamofire


class GoGakuAPIRequest<T: JsonType>: URLRequestConvertible {
    
    var path: String { fatalError("上書き必須") }
    var method: HTTPMethod { fatalError("上書き必須") }
    var parameters: Parameters? {
        return nil
    }
    
    var encoding: ParameterEncoding = {
        return JSONEncoding.prettyPrinted
    }()
    
    var headers: HTTPHeaders {
        let fields: HTTPHeaders = [
            "Accept": "application/json",
            "Cache-Control": "no-cache",
            "Content-Type": "application/json",
            "Authorization" : "Basic",
            "X-app-version-ios" : Platform.bundleShortVersion
        ]
        return fields
    }

    func asURLRequest() throws -> URLRequest {
        let url = try GoGakuAPIConfig.baseURL.asURL()
        var urlRequest = URLRequest(url: url.addPath(path))
        // Method
        urlRequest.httpMethod = method.rawValue
        // Headers
        urlRequest.headers = headers
        return try encoding.encode(urlRequest, with: parameters)
    }
}
