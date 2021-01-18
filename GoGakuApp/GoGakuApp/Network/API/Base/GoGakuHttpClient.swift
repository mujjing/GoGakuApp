//
//  GoGakuHttpClient.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/17.
//

import Foundation

final class GoGakuHttpClient: HttpClient {

    static var `default` = GoGakuHttpClient()

    override func commonResponseHandler<BodyType>(response: HttpResponse<BodyType>) -> HttpResponse<BodyType>? {

        if [200, 204].contains(response.status_code) {
            return response
        }

        return nil
    }

    // To convert snake -> camel
//    override var jsonDecoder: JSONDecoder? {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        return decoder
//    }


}
