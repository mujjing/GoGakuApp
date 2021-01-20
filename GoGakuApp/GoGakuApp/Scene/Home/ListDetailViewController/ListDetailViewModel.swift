//
//  ListDetailViewModel.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/18.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

class ListDetailViewModel:NSObject {
    var list : [ListWordGet] = []
    var count : Int?
    
    func listWordDelete() -> Single<ListWordDeleteResponse> {
        let request = ListWordDeleteRequest()
        let task = GoGakuHttpClient.default.send(request)
            .do(onSuccess: { response in
                debugPrint("listWordDelete : \(response.data)")
            })
        .asObservable()
        .share()
        .asSingle()
        task.subscribe().disposed(by: disposeBag)
        return task
    }
    
    func listWordUpdate(word: String, mean: String) -> Single<ListWordUpdateResponse> {
        let request = ListWordUpdateRequest(word: word, mean: mean)
        let task = GoGakuHttpClient.default.send(request)
            .do(onSuccess: { response in
                
            })
        .asObservable()
        .share()
        .asSingle()
        task.subscribe().disposed(by: disposeBag)
        return task
    }
    func listWordAdd(word: String, mean: String) -> Single<ListWordAddResponse> {
        let request = ListWordAddRequest(word: word, mean: mean)
        let task = GoGakuHttpClient.default.send(request)
            .do(onSuccess: { response in
                
            })
        .asObservable()
        .share()
        .asSingle()
        task.subscribe().disposed(by: disposeBag)
        return task
    }
}
