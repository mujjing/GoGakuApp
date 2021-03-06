//
//  ListWordAddRequest.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/19.
//

import Foundation
import Alamofire

final class ListWordAddRequest: GoGakuAPIRequest<ListWordAddResponse> {

    override var method: HTTPMethod {
        return .post
    }

    override var path: String {
        return "/api/listword/add/\(id.listID)"
    }
    var id = IDDelivery.shared
    var word: String
    var mean: String

    override var parameters: Parameters? {
         let params: [String: Any] = [
            "word" : word ,
            "mean" : mean ,
         ]
         return params
     }
    
    // MARK: Initializers
    init(word: String, mean: String) {
        self.word = word
        self.mean = mean
    }


}
