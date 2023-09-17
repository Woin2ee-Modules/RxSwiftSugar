@testable import RxUtility
import RxSwift
import RxBlocking
import RxTest
import XCTest

final class RxUtilityTests: XCTestCase {

    var disposeBag: DisposeBag!

    var testScheduler: TestScheduler!

    let errorEmitTime = 300

    override func setUpWithError() throws {
        try super.setUpWithError()
        disposeBag = .init()
        testScheduler = .init(initialClock: 0)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        disposeBag = nil
        testScheduler = nil
    }

    func test_asDriverOnErrorJustComplete() {
        // Arrange
        let errorTrigger: TestableObservable<Int> = testScheduler.createHotObservable([.error(errorEmitTime, TestingError.testingError)])
        // Act
        let result = testScheduler.start {
            errorTrigger.asDriverOnErrorJustComplete()
        }
        // Assert
        XCTAssertEqual(result.events, [Recorded.completed(errorEmitTime, Int.self)])
    }

    func test_asSignalOnErrorJustComplete() {
        // Arrange
        let errorTrigger: TestableObservable<Int> = testScheduler.createHotObservable([.error(errorEmitTime, TestingError.testingError)])
        // Act
        let result = testScheduler.start {
            errorTrigger.asSignalOnErrorJustComplete()
        }
        // Assert
        XCTAssertEqual(result.events, [Recorded.completed(errorEmitTime, Int.self)])
    }

    func test_asDriverOnErrorJustNext() {
        // Arrange
        let errorTrigger: TestableObservable<Void> = testScheduler.createHotObservable([.error(errorEmitTime, TestingError.testingError)])
        // Act
        let result = testScheduler.start {
            errorTrigger.asDriverOnErrorJustNext()
        }
        // Assert
        XCTAssertContainsRecordedElement(result.events, Recorded.next(errorEmitTime, ()))
    }

    func test_asSignalOnErrorJustNext() {
        // Arrange
        let errorTrigger: TestableObservable<Void> = testScheduler.createHotObservable([.error(errorEmitTime, TestingError.testingError)])
        // Act
        let result = testScheduler.start {
            errorTrigger.asSignalOnErrorJustNext()
        }
        // Assert
        XCTAssertContainsRecordedElement(result.events, Recorded.next(errorEmitTime, ()))
    }

    func test_mapToAnyAtSingle() throws {
        // Arrange
        let singleSequence: Single<Int> = .just(3)

        // Act
        let anyElement = try singleSequence
            .mapToAny()
            .toBlocking()
            .single()

        // Assert
        XCTAssertEqual(anyElement as? Int, 3)
    }

    func test_mapToAnyAtObservableType() throws {
        // Arrange
        let observableSequence: Observable<Int> = .just(3)

        // Act
        let anyElement = try observableSequence
            .mapToAny()
            .toBlocking()
            .single()

        // Assert
        XCTAssertEqual(anyElement as? Int, 3)
    }

}
