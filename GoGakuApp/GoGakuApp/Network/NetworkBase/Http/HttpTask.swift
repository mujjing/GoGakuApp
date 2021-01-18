//
//  HttpTask.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/17.
//

import Foundation

open class HttpTask<BodyType> {

    var request: URLRequest
    var session: URLSession

    private var task: URLSessionTask?

    var commonResponseHandler: ((HttpResponse<BodyType>) -> HttpResponse<BodyType>?)?

    var jsonDecoder: JSONDecoder = JSONDecoder()

    private var _onError: ((Error) -> Void)?
    private var _onSuccess: ((HttpResponse<BodyType>) -> Void)?

    init(session: URLSession, request: URLRequest) {
        self.session = session
        self.request = request
    }

    func execute() -> Self {
        task = session.dataTask(with: request) { (data, response, err) in
            if err != nil {
                self._onError?(err!)
                return
            }

            // TODO: エラー系処理見直し
            guard let nsRes = (response as? HTTPURLResponse),
                let headers = (nsRes.allHeaderFields as? [String: String]),
                let data = data
            else {
                self._onError?(NSError(domain: "レスポンス形式不正", code: 0, userInfo: nil))
                return
            }
            guard let body = self.parseBody(data)
            else {
                self._onError?(NSError(domain: "レスポンス形式不正", code: nsRes.statusCode, userInfo: nil))
                return
            }
            
            if let res = self.commonResponseHandler?(HttpResponse(status_code: nsRes.statusCode, headers: headers, body: body)) {
                self._onSuccess?(res)
            }
        }
        task?.resume()
        return self
    }

    func parseBody(_ data: Data) -> BodyType? {
        return data as? BodyType
    }

    public func onSuccess(_ next: @escaping (HttpResponse<BodyType>) -> Void) -> Self {
        _onSuccess = next
        return self
    }
    func onError(_ next: @escaping (Error) -> Void) -> Self {
        _onError = next
        return self
    }

    func cancel() {
        task?.cancel()
    }
}

class JsonHttpTask<BodyType: JsonType>: HttpTask<BodyType> {

    override func parseBody(_ data: Data) -> BodyType? {
        do {
            return try self.jsonDecoder.decode(BodyType.self, from: data)
        } catch {
            return nil
        }
    }
}
