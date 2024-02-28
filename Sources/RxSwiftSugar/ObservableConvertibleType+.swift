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
