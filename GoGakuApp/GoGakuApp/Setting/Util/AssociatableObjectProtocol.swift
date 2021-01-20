//
//  AssociatableObjectProtocol.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/20.
//

import Foundation

/// extension で stored property を擬似的に追加したい場合に採用させる。
/// 参考: http://www.tokoro.me/posts/has-associated-objects/
/// - Note: 例 兼 やりたかったことを /App/Extension/NSObject+BABYCARE.swift に実装する。全ての NSObject に DisposeBag を持たせる。
protocol AssociatableObjectProtocol: AnyObject {
    
    var associatedObjectContainer: AssociatedObjectContainer { get }
    
}

extension AssociatableObjectProtocol {
    
    var associatedObjectContainer: AssociatedObjectContainer {
        if let objects = objc_getAssociatedObject(self, &AssociatedObjectContainerAssociationKey) as? AssociatedObjectContainer {
            return objects
        } else {
            let objects = AssociatedObjectContainer()
            objc_setAssociatedObject(self, &AssociatedObjectContainerAssociationKey, objects, .OBJC_ASSOCIATION_RETAIN)
            return objects
        }
    }
    
}

private var AssociatedObjectContainerAssociationKey: UInt8 = 0

final class AssociatedObjectContainer {
    
    typealias KeyType = String
    
    var objects: [KeyType: Any] = [:]
    
    subscript(key: KeyType) -> Any? {
        get { return objects[key] }
        set { objects[key] = newValue }
    }
    
}
