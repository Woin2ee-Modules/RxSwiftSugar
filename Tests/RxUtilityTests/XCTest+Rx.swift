//
//  XCTest+Rx.swift
//  
//
//  Created by Jaewon Yun on 2023/08/22.
//

import Foundation
import RxSwift
import RxTest
import XCTest

func XCTAssertRecordedElements(_ stream: [Recorded<Event<Void>>], _ elements: [Void], file: StaticString = #file, line: UInt = #line) {
    if let stopEvent = stream.first(where: { $0.value.isStopEvent }) {
        #if os(Linux)
        XCTFail("A non-next stop event has been emitted: \(stopEvent)")
        #else
        XCTFail("A non-next stop event has been emitted: \(stopEvent)", file: file, line: line)
        #endif
        return
    }
    
    let equatableStream = stream.map { event in
        switch event.value {
        case .next:
            return Recorded.next(event.time, true)
        default:
            fatalError("Non-next stop event should cause assertion")
        }
    }
    let equatableElements = elements.map { true }
    
    XCTAssertRecordedElements(equatableStream, equatableElements, file: file, line: line)
}

func XCTAssertContainsRecordedElement(_ stream: [Recorded<Event<Void>>], _ element: Recorded<Event<Void>>, file: StaticString = #file, line: UInt = #line) {
    let equatableStream = stream.map { event in
        switch event.value {
        case .next:
            return Recorded.next(event.time, true)
        case .error(let error):
            return Recorded.error(event.time, error)
        case .completed:
            return Recorded.completed(event.time)
        }
    }
    let equatableElement: Recorded<Event<Bool>> = .init(
        time: element.time,
        value: {
            switch element.value {
            case .next:
                return .next(true)
            case .error(let error):
                return .error(error)
            case .completed:
                return .completed
            }
        }()
    )
    
    #if os(Linux)
    XCTAssert(equatableStream.contains(equatableElement))
    #else
    XCTAssert(equatableStream.contains(equatableElement), file: file, line: line)
    #endif
    
    if !equatableStream.contains(equatableElement) {
        print("In stream :")
        print(stream)
    }
}
