<p align="center">
<img src="Resources/logo.svg" alt="PhantomKit logo" height=200>
</p>
<p align="center">
  <a href="https://github.com/pawello2222/PhantomKit"><img src="https://img.shields.io/github/workflow/status/pawello2222/PhantomKit/build?logo=github" alt="Build"></a>
  <a href="https://app.codecov.io/gh/pawello2222/PhantomKit"><img src="https://img.shields.io/codecov/c/github/pawello2222/PhantomKit?logo=codecov" alt="Code coverage"></a>
  <a href="https://github.com/pawello2222/PhantomKit"><img src="https://img.shields.io/badge/language-swift-orange.svg" alt="Language"></a>
  <a href="https://github.com/pawello2222/PhantomKit"><img src="https://img.shields.io/badge/platform-iOS-lightgrey" alt="Supported Platform"></a>
  <a href="https://github.com/pawello2222/PhantomKit"><img src="https://img.shields.io/badge/SPM-compatible-brightgreen.svg" alt="Swift Package Manager"></a>
  <a href="https://github.com/pawello2222/PhantomKit/releases"><img src="https://img.shields.io/github/v/release/pawello2222/PhantomKit" alt="Release version"></a>
  <a href="https://github.com/pawello2222/PhantomKit/blob/main/LICENSE"><img src="https://img.shields.io/github/license/pawello2222/PhantomKit" alt="License"></a>
</p>

# PhantomKit

PhantomKit is a collection of many useful Swift and SwiftUI extensions and components. It is an _invisible_ layer that supports your application and makes writing Swift code easier.

## Requirements
* iOS 14.0+
* Xcode 12.0+
* Swift 5.3+

## Installation

### Swift Package Manager

PhantomKit is available as a Swift Package.

Alternatively, you can add PhantomKit as a SPM dependency:

```swift
.package(url: "https://github.com/pawello2222/PhantomKit.git", .upToNextMajor(from: "0.0.1"))
```

Tip: to make PhantomKit _truly invisible_ add the below line in the main file:
```swift
@_exported import PhantomKit
```

## Highlights

### Opening a NavigationLink on tap gesture

- Natively
```swift
@State private var isActive = false
```
```swift
NavigationLink("", destination: Text("Destination"), isActive: $isActive)
Text("Go to...")
    .onTapGesture {
        isActive = true
    }
```

- With PhantomKit
```swift
Text("Go to...")
    .link(triggeredBy: .tap, destination: Text("Destination"))
```

### Executing an action before and after opening a NavigationLink

```swift
Text("Go to...")
    .presentation(method: .link, onTrigger: {}, onDismiss: {}) {
        Text("Destination")
    }
```

### Opening a Web View

```swift
extension WebEndpoint {
    static var feedback: Self {
        .init(
            title: "Feedback",
            url: URL(string: "<feedback_url>")
        )
    }
}
```
```swift
Text("Share feedback")
    .webView(endpoint: .feedback)

Text("Share feedback")
    .webView(triggeredBy: .plainButton endpoint: .feedback)
    
Text("Share feedback")
    .webView(openedAs: .fullScreen, endpoint: .feedback, edgesIgnoringSafeArea: .all) {
        print("onDismiss")
    }
```

### SwiftUI extensions

- `aligned`

```swift
public func aligned(_ alignemnt: HorizontalAlignment) -> some View

public func aligned(_ alignemnt: VerticalAlignment) -> some View
```

Before
```swift
HStack {
    Spacer()
    Text("Hello World")
}
```

After
```swift
Text("Hello World")
    .aligned(.trailing)
```

- `expandingBackgroundColor`

```swift
public func expandingBackgroundColor(_ color: Color, edgesIgnoringSafeArea: Edge.Set = .all) -> some View
```

Before
```swift
ZStack {
    Color.red
        .edgesIgnoringSafeArea(edgesIgnoringSafeArea)
    Text("Hello World")
}
```

After
```swift
Text("Hello World")
    .expandingBackgroundColor(.red)
```

### Xcore extensions

- Date manipulation

Before
```swift
let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())!
let isSameMonth = Calendar.current.compare(nextMonth, to: Date(), toGranularity: .month) == .orderedSame
```

After
```swift
let nextMonth = Date().adjusting(.month, by: 1)
let isSameMonth = Date().isSame(nextMonth, granularity: .month)
```

- In-flight modifications with `Appliable` and `MutableAppliable`

Before
```swift
static let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.locale = .init(identifier: "en_US_POSIX")
    formatter.maximumFractionDigits = 3
    return formatter
}()
```

After
```swift
static let numberFormatter = NumberFormatter().apply {
    $0.locale = .usPosix
    $0.maximumFractionDigits = 3
}
```

and many more...!

## Reference

### Routing

Two enums for native SwiftUI routing:

```swift
extension PresentationMethod {
    public enum Transition {
        case link
        case sheet
        case fullScreen
    }
}
```

```swift
extension PresentationMethod {
    public enum Trigger {
        case tap
        case button(style: AnyButtonStyle)
        case primitiveButton(style: AnyPrimitiveButtonStyle)
    }
}
```

View helpers:

```swift
extension View {
    public func presentation<Content>(
        method: PresentationMethod,
        onTrigger: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View
```

Examples:

```swift
Text("Go to...")
    .presentation(method: .link, onTrigger: {}, onDismiss: {}) {
        Text("Destination")
    }

Text("Go to...")
    .link(triggeredBy: .tap, destination: Text("Destination"))

Text("Go to...")
    .sheet(triggeredBy: .plainButton, destination: Text("Sheet"))

Text("Go to...")
    .fullScreen(triggeredBy: .styledButton(BorderlessButtonStyle()), destination: Text("Full Screen"))

Text("Go to...")
    .actionSheet(triggeredBy: .fillButton) {
        ActionSheet(...)
    }
```

### Formatting

#### LocalizedFormatter

A custom `LocalizedFormatter` that automatically formats numbers, decimals and currencies for a specified locale:

```swift
extension LocalizedFormatter {
    public static var currency = makeCurrencyFormatter(locale: .current, currencyCode: "USD")
    public static var decimal = makeDecimalFormatter(locale: .current)
    public static var percent = makePercentFormatter(locale: .current)
}
```

Examples:

```swift
let formatter = LocalizedFormatter.makeDecimalFormatter(locale: .init(identifier: "en_US"))

expect(formatter.string(from: 48_729_432)).to(equal("48,729,432"))
expect(formatter.string(from: 48_729_432, abbreviation: .capitalized)).to(equal("48.73M"))
expect(formatter.string(from: 123.456, sign: .both)).to(equal("+123.46"))
expect(formatter.string(from: 0.123456789, precision: .default)).to(equal("0.12"))
expect(formatter.string(from: 0.123456789, precision: .constant(4))).to(equal("0.1235"))
```

```swift
let formatter = LocalizedFormatter.makeCurrencyFormatter(locale: .init(identifier: "en_US"), currencyCode: "USD")

expect(formatter.string(from: 432)).to(equal("$432.00"))
expect(formatter.string(from: 1432.99, abbreviation: .default)).to(equal("$1.43k"))
expect(formatter.string(from: 123.456, sign: .both)).to(equal("+$123.46"))
```

#### LocalizedDateFormatter

A custom `LocalizedDateFormatter` that automatically formats date and time for a specified locale:

```swift
extension LocalizedDateFormatter {
    public static var date = makeDateFormatter(localizedFormat: "yyyyMMdd")
    public static var datetime = makeDateFormatter(localizedFormat: "yyyyMMddjjmmss")
}
```

Examples:

```swift
let formatter = LocalizedDateFormatter.makeDateFormatter(locale: .init(identifier: "pl_PL"))

let date = Date(year: 2000, month: 3, day: 24)

expect(formatter.string(from: date)).to(equal("24.03.2000"))
```

```swift
let formatter = LocalizedDateFormatter.makeDateFormatter(
    locale: .init(identifier: "en_US"),
    localizedFormat: "yyyyMMddjjmmss"
)

let date = Date(year: 2000, month: 3, day: 24, hour: 16, minute: 14, second: 44)

expect(formatter.string(from: date)).to(equal("03/24/2000, 4:14:44 PM"))
```

## Roadmap

- [x] SwiftUI
- [x] Routing
- [x] Localized formatters
- [x] Network layer
- [x] Third party extensions 
    - [x] [Defaults](https://github.com/sindresorhus/Defaults)
    - [x] [Moya](https://github.com/Moya/Moya)
- [x] SPM compatibility
- [ ] Database extensions
    - [ ] Core Data
    - [ ] Realm
- [ ] Complete documentation

## Dependencies

PhantomKit exports globally the following frameworks making them accessible just by importing PhantomKit alone:

- [duemunk/Async](https://github.com/duemunk/Async)
- [zmian/Xcore](https://github.com/zmian/xcore)

## License

PhantomKit is available under the MIT license. See the [LICENSE](https://github.com/pawello2222/PhantomKit/blob/main/LICENSE) file for more info.
