//
//  Platform.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/20.
//

import Foundation

struct Platform {
    
    static let bundleVersion: String! = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    static let bundleShortVersion: String! = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    static let targetName: String! = Bundle.main.object(forInfoDictionaryKey: "TargetName") as? String
    
    // MARK: Uninitializable
    
    private init() {}
    
}
