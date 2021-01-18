//
//  GoGakuWebConfig.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/17.
//

import Foundation

protocol GoGakuWebConfigProtocol {

    static var domain: String { get }

}

struct GoGakuWebConfig: GoGakuWebConfigProtocol {

    // インスタンス化させない
    private init() {}

}
