//
//  Functions.swift
//  
//
//  Created by Jaewon Yun on 2023/08/22.
//

import Foundation

func unwrapOrThrow<T>(_ optionalValue: T?) throws -> T {
    guard let unwrappedValue = optionalValue else {
        throw RxUtilityError.nilValue(objectType: T.self)
    }
    return unwrappedValue
}
