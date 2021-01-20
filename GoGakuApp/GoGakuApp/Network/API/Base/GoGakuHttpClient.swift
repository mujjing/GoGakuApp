//
//  GoGakuHttpClient.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/17.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class GoGakuHttpClient: HttpClient {

    static var `default` = GoGakuHttpClient()
    func send<T: JsonType>(_ request: GoGakuAPIRequest<T>) -> Single<T> {
        return self.request(request)
    }
    
    //MARK: - The request function to get results in an Observable
    private func request<T: JsonType> (_ urlConvertible: URLRequestConvertible) -> Single<T> {
        return Single.create { event in
            let task = AF.request(urlConvertible)
                .responseDecodable { (response: DataResponse<T, AFError>) in
                switch response.result {
                    case .success(let result):
                        event(.success(result))
                    case .failure(let error):
                        switch response.response?.statusCode {
                            case 400:
                                debugPrint("400error")
                            case 401:
                                debugPrint("401error")
                            case 403:
                                debugPrint("403error")
                            case 404:
                                debugPrint("404error")
                            case 409:
                                debugPrint("409error")
                            case 500:
                                debugPrint("500error")
                            case 503:
                                debugPrint("503error")
                            default:
                                event(.error(error))
                        }
                }
            }
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

    // To convert snake -> camel
//    override var jsonDecoder: JSONDecoder? {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        return decoder
//    }


