//
//  ListAddViewModel.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/11.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
class ListAddViewModel: NSObject {
    var wordList:[ListWordGet] = []
    
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
