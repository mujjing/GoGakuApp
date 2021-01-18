//
//  ListSetViewModel.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/11.
//

import UIKit

class ListSetViewModel: NSObject {
    
    var dummy: [dummyData] = [
        dummyData(image: "ICON1", name: "Lolep"),
        dummyData(image: "ICON2", name: "sample2"),
    ]
    var list : [ListSet] = []
    
}

struct dummyData {
    let image : String?
    let name : String
}
