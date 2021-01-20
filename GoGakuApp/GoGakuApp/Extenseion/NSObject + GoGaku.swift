//
//  NSObject + GoGaku.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/20.
//

import Foundation
import RxSwift

extension NSObject: AssociatableObjectProtocol {
    
    var disposeBag: DisposeBag {
        let key = "disposeBag"
        if let bag = associatedObjectContainer[key] as? DisposeBag {
            return bag
        } else {
            let bag = DisposeBag()
            associatedObjectContainer[key] = bag
            return bag
        }
    }
    
}


extension Range where Bound == String.Index {
    var nsRange: NSRange {
        return NSRange(location: self.lowerBound.encodedOffset, length: self.upperBound.encodedOffset - self.lowerBound.encodedOffset)
    }
}

