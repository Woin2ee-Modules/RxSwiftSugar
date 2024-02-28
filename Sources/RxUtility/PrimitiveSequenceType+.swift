import RxSwift
import RxCocoa

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

    public func catchAndThenJustNext() -> Single<Void> {
        return self.primitiveSequence
            .catch { _ in return .empty() }
            .andThen(Single<Void>.just(()))
    }

}
