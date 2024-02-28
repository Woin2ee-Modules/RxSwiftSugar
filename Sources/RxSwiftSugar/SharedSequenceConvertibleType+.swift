import RxSwift
import RxCocoa

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
