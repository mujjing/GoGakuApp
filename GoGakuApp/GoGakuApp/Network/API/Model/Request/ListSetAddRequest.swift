//
//  ListSetAddRequest.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/19.
//

import Foundation
import Alamofire

final class ListSetAddRequest: GoGakuAPIRequest<ListSetAddResponse> {

    override var method: HTTPMethod {
        return .post
    }

    override var path: String {
        return "/api/listset/add"
    }

    override var parameters: Parameters? {
         let params: [String: Any] = [
             "title" : title ?? "",
             "image" : image ?? "",
         ]
         return params
     }
    var title: String?
    var image: String?
    
    // MARK: Initializers
    init(title: String?, image: String?) {
        self.title = title
        self.image = image
    }

}
