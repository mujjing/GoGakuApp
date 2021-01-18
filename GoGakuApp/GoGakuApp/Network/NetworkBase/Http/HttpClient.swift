//
//  HttpClient.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/17.
//

import Foundation

open class HttpClient {

    //TODO: 基盤グロバル変数へ移行
    open var timeoutIntervalForRequest: TimeInterval = 30.0
    open var timeoutIntervalForResource: TimeInterval = 60.0

    open var config: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.timeoutIntervalForRequest = timeoutIntervalForRequest
        config.timeoutIntervalForResource = timeoutIntervalForResource
        return config
    }

    open var session: URLSession {
        return URLSession(configuration: config)
    }

    // To override jsonDecoder in HttpTask
    open var jsonDecoder: JSONDecoder? {
        return nil
    }

    public func send<BodyType: JsonType>(_ request: HttpRequest<BodyType>) throws -> HttpTask<BodyType> {
         return try createJsonTask(request).execute()
    }
    public func send(_ request: HttpRequest<Data>) throws -> HttpTask<Data> {
        return try createTask(request).execute()
    }

    public init() {}
    open func commonResponseHandler<BodyType>(response: HttpResponse<BodyType>) -> HttpResponse<BodyType>? {
        return response
    }
    private func createTask<BodyType>(_ request: HttpRequest<BodyType>) throws -> HttpTask<BodyType> {

        guard let req = parseRequest(request) else {
            throw NSError(domain: "xxx", code: 1111, userInfo: nil)
        }

        let task = HttpTask<BodyType>(session: session, request: req)
        task.commonResponseHandler = commonResponseHandler

        return task
    }

    private func createJsonTask<BodyType: JsonType>(_ request: HttpRequest<BodyType>) throws -> JsonHttpTask<BodyType> {

        guard let req = parseRequest(request) else {
            throw NSError(domain: "xxx", code: 1111, userInfo: nil)
        }

        let task = JsonHttpTask<BodyType>(session: session, request: req)
            task.commonResponseHandler = commonResponseHandler

        if let jsonDecoder = self.jsonDecoder {
            task.jsonDecoder = jsonDecoder
        }

        return task
    }

    private func parseRequest<BodyType>(_ request: HttpRequest<BodyType>) -> URLRequest? {
        guard let url = URL(string: request.endPoint) else {
            return nil
        }
        var req = URLRequest(url: url)

        req.httpMethod = request.method.rawValue

        request.headers.forEach { (kv) in
            let (key, val) = kv
            req.addValue(val, forHTTPHeaderField: key)
        }

        if request.isJsonRequest {
            do {
                req.httpBody = try JSONSerialization.data(withJSONObject: request.parameters, options: [.prettyPrinted])
            } catch {
                return nil
            }
        } else {
            let parameterArray = request.parameters.map { (arg) -> String in
                let (key, value) = arg
                return "\(key)=\(value)"
            }
            req.httpBody = parameterArray.joined(separator: "&").data(using: String.Encoding.utf8)
        }
        return req
    }
}
