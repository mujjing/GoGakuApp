//
//  ListSetViewModel.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/11.
//

import UIKit

class ListSetViewModel: NSObject {
    
    var dummy: [dummyData] = [
        dummyData(image: UIImage(named: "sample1"), name: "Lolep"),
        dummyData(image: UIImage(named: "sample2"), name: "sample2"),
    ]
    
}

struct dummyData {
    let image : UIImage?
    let name : String
}
