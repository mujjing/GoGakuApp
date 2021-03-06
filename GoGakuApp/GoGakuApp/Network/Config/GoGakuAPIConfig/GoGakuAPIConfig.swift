//
//  GoGakuAPIConfig.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/17.
//

import Foundation

protocol GoGakuAPIConfigProtocol {

    static var domain: String { get }

}

struct GoGakuAPIConfig: GoGakuAPIConfigProtocol {
    static var baseURL: URL {
        return URL(string: baseURLString)!
    }
    // インスタンス化させない
    private init() {}

}

