# RxExtension

This library supports convenient operators of RxSwift / RxCooca.

The list of supported operators is <a href="#SupportedOperators">here</a>.

## Requirements
- Xcode 12.x
- Swift 5.x

## Installation

### Swift Package Manager

```
dependencies: [
    .package(url: "https://github.com/woin2ee/RxUtility.git", .upToNextMajor(from: "1.0.0"))
]
```

<h2 id="SupportedOperators">Supported operators</h2>

```swift
func asDriverOnErrorJustComplete() -> Driver<Element>
    
func asSignalOnErrorJustComplete() -> Signal<Element>
```
```swift
// when Element == Void

func asDriverOnErrorJustNext() -> Driver<Void>

func asSignalOnErrorJustNext() -> Signal<Void>
```
```swift
func mapToVoid() -> AnyObservableType<Void>

func mapToAny() -> AnyObservableType<Any>
    
func doOnNext(_ block: ((Element) throws -> Void)?) -> AnyObservableType<Element>

func doOnCompleted(_ block: (() throws -> Void)?) -> AnyObservableType<Element>

func doOnSuccess(_ block: ((Element) throws -> Void)?) -> Single<Element>
```
```swift
func startWith(_ block: () -> Element) -> SharedSequence<SharingStrategy, Element>

.startWith {
    if text.isEmpty {
        return "A"
    } else {
        return "B"
    }
}
```
```swift
func unwrapOrThrow<Result>() -> AnyObservableType<Result>

array
    .map(\.first)
    .unwrapOrThrow() // If nil, throw error.
```
```swift
func andThenJustNext() -> Single<Void>

delete() // Return Completable
    .andThenJustNext() // Use it if want `next` event.
```
