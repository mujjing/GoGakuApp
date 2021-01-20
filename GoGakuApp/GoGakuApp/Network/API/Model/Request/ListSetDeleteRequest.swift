//
//  ListSetDeleteRequest.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/19.
//

import Foundation
import Alamofire

final class ListSetDeleteRequest: GoGakuAPIRequest<ListSetDeleteResponse> {

    override var method: HTTPMethod {
        return .delete
    }

    override var path: String {
        return "/api/listset/delete/\(id.listID)"
    }

    var id = IDDelivery.shared
    
    override var parameters: Parameters? {
         let params: [String: Any] = [
            "" : ""
         ]
         return params
     }
}
