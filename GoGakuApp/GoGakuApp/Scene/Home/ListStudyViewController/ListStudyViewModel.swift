//
//  ListStudyViewModel.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/14.
//

import Foundation

class ListStudyViewModel: NSObject {
    var dummy: [sampleData] = [
        sampleData(image: "ICON1", name: "Lolep"),
        sampleData(image: "ICON2", name: "sample2"),
    ]
    
}

struct sampleData {
    let image : String?
    let name : String
}

