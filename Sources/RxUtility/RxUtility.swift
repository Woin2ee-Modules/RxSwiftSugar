//
//  RxUtility.swift
//  
//
//  Created by Jaewon Yun on 2023/08/22.
//

import RxSwift
import RxCocoa

extension ObservableConvertibleType {

    public func asDriverOnErrorJustComplete() -> Driver<Element> {
        return self.asDriver(onErrorDriveWith: .empty())
    }

    public func asSignalOnErrorJustComplete() -> Signal<Element> {
        return self.asSignal(onErrorSignalWith: .empty())
    }

}

extension ObservableConvertibleType where Element == Void {

    public func asDriverOnErrorJustNext() -> Driver<Element> {
        return self.asDriver(onErrorJustReturn: ())
    }

    public func asSignalOnErrorJustNext() -> Signal<Element> {
        return self.asSignal(onErrorJustReturn: ())
    }

}

extension ObservableType {

    public func mapToVoid() -> Observable<Void> {
        return self.map { _ in }
    }

    public func mapToAny() -> Observable<Any> {
        return self.map { $0 as Any }
    }

    public func doOnNext(_ block: ((Element) throws -> Void)?) -> Observable<Element> {
        return self.do(onNext: block)
    }

    public func doOnCompleted(_ block: (() throws -> Void)?) -> Observable<Element> {
        return self.do(onCompleted: block)
    }

    public func unwrapOrThrow<Result>() -> Observable<Result> where Element == Result? {
        return self.map { try RxUtility.unwrapOrThrow($0) }
    }

}

extension SharedSequenceConvertibleType {

    public func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return self.map { _ in }
    }

    public func mapToAny() -> SharedSequence<SharingStrategy, Any> {
        return self.map { $0 as Any }
    }

    public func doOnNext(_ block: ((Element) -> Void)?) -> SharedSequence<SharingStrategy, Element> {
        return self.do(onNext: block)
    }

    public func doOnCompleted(_ block: (() -> Void)?) -> SharedSequence<SharingStrategy, Element> {
        return self.do(onCompleted: block)
    }

    public func startWith(_ block: () -> Element) -> SharedSequence<SharingStrategy, Element> {
        return startWith(block())
    }

}

extension PrimitiveSequenceType where Trait == SingleTrait {

    public func mapToVoid() -> PrimitiveSequence<Trait, Void> {
        return self.map { _ in }
    }

    public func mapToAny() -> PrimitiveSequence<Trait, Any> {
        return self.map { $0 as Any }
    }

    public func doOnSuccess(_ block: ((Element) throws -> Void)?) -> PrimitiveSequence<Trait, Element> {
        return self.do(onSuccess: block)
    }

    public func unwrapOrThrow<Result>() -> PrimitiveSequence<Trait, Result> where Element == Result? {
        return self.map { try RxUtility.unwrapOrThrow($0) }
    }

}

extension PrimitiveSequenceType where Trait == MaybeTrait {

    public func mapToVoid() -> PrimitiveSequence<Trait, Void> {
        return self.map { _ in }
    }

}

extension PrimitiveSequenceType where Trait == CompletableTrait, Element == Never {

    public func andThenJustNext() -> Single<Void> {
        return self.andThen(.just(()))
    }

}
