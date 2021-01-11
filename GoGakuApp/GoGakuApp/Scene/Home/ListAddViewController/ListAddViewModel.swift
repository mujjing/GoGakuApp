//
//  ListAddViewModel.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/11.
//

import Foundation

class ListAddViewModel: NSObject {
    var dummyTable : [dummyTableData] = [
        dummyTableData(word: "baseBall", mean: "野球")
    ]
}

struct dummyTableData {
    let word: String
    let mean: String
}
