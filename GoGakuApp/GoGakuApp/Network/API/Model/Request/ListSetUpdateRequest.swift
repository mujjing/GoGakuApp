//
//  ListSetUpdateRequest.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/19.
//

import Foundation
import Alamofire
final class ListSetUpdateRequest: GoGakuAPIRequest<ListSetUpdateResponse> {

    override var method: HTTPMethod {
        return .put
    }

    override var path: String {
        return "/api/listset/update/\(id.listID)"
    }
    var id = IDDelivery.shared
    var title: String?
    var image: String?

    override var parameters: Parameters? {
         let params: [String: Any] = [
             "title" : title ?? "",
             "image" : image ?? "",
         ]
         return params
     }
    
    // MARK: Initializers
    init(title: String?, image: String?) {
        self.title = title
        self.image = image
    }

}
