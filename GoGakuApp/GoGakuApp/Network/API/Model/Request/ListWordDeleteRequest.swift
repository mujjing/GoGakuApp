//
//  ListWordDeleteRequest.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/19.
//

import Foundation
import Alamofire

final class ListWordDeleteRequest: GoGakuAPIRequest<ListWordDeleteResponse> {

    override var method: HTTPMethod {
        return .delete
    }

    override var path: String {
        return "/api/listword/delete/\(id.wordID)"
    }

    var id = IDDelivery.shared
    
    override var parameters: Parameters? {
         let params: [String: Any] = [
            "" : ""
         ]
         return params
     }
}
