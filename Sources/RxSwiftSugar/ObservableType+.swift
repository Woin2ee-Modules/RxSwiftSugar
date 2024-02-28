import RxSwift
import RxCocoa

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
}

extension ObservableType where Element: ExpressibleByNilLiteral {

    /// Unwraps elements or throws error if nil elements.
    public func unwrapOrThrow<Result>() -> Observable<Result> where Element == Result? {
        return self.map { try RxSwiftSugar.unwrapOrThrow($0) }
    }

    /// Unwraps elements and skips nil elements. Equivalent to apply `compactMap` operator without `transform`.
    public func unwrapOrIgnore<Result>() -> Observable<Result> where Element == Result? {
        return self.compactMap { $0 }
    }
}
