//
//  ListTitleViewModel.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/19.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa


class ListTitleViewModel: NSObject {
    var imageName = ""
    var imageFileName = [ "ICON1", "ICON2", "ICON3", "ICON4", "ICON5", "ICON6", "ICON7", "ICON8", "ICON9", "ICON10", "ICON11", "ICON12", "ICON13", "ICON14", "ICON15", "ICON16", "ICON17", "ICON18", "ICON19", "ICON20", "ICON21", "ICON22", "ICON23", "ICON24", "ICON25", "ICON26", "ICON27", "ICON28", "ICON29", "ICON30"]
    
    
    func listTitleSet(title: String?, image: String?) -> Single<ListSetAddResponse> {
        let request = ListSetAddRequest(title: title, image: image)
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
