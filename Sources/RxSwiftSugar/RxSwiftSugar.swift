//
//  Error.swift
//  
//
//  Created by Jaewon Yun on 2023/08/22.
//

import Foundation

enum RxSwiftSugarError: Error {

    case nilValue(objectType: Any.Type)

}

func unwrapOrThrow<T>(_ optionalValue: T?) throws -> T {
    guard let unwrappedValue = optionalValue else {
        throw RxSwiftSugarError.nilValue(objectType: T.self)
    }
    return unwrappedValue
}
