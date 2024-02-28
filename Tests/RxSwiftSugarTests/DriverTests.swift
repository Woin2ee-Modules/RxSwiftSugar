//
//  DriverTests.swift
//  
//
//  Created by Jaewon Yun on 2/28/24.
//

import RxSwiftSugar

import RxSwift
import RxBlocking
import XCTest

final class DriverTests: XCTestCase {

    func test_unwrapOrIgnore() {
        let observable: Observable<Int?> = .of(1, 2, nil, 4, 5)
        let result = observable
            .asDriverOnErrorJustComplete()
            .unwrapOrIgnore()
            .toBlocking()
            .materialize()

        switch result {
        case .completed(let elements):
            XCTAssertEqual(elements, [1, 2, 4, 5])
        case .failed(_, let error):
            XCTFail("Expected result to complete without error, but received \(error).")
        }
    }
}
