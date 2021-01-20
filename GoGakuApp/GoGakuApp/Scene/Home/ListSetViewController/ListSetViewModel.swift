//
//  ListSetViewModel.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/11.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa
class ListSetViewModel: NSObject {

    var list : [ListSet] = []
    
    func listDelete() -> Single<ListSetDeleteResponse> {
        let request = ListSetDeleteRequest()
        let task = GoGakuHttpClient.default.send(request)
            .do(onSuccess: { response in
                debugPrint("listSetDelete : \(response.data)")
            })
        .asObservable()
        .share()
        .asSingle()
        task.subscribe().disposed(by: disposeBag)
        return task
    }
    
}
