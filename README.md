<p align="center">
<img src="Resources/logo.svg" alt="PhantomKit logo" height=200>
</p>
<p align="center">
  <a href="https://github.com/pawello2222/PhantomKit"><img src="https://img.shields.io/badge/language-swift-orange.svg" alt="Language"></a>
  <a href="https://github.com/pawello2222/PhantomKit"><img src="https://img.shields.io/badge/platform-iOS-lightgrey" alt="Supported Platform"></a>
  <a href="https://github.com/pawello2222/PhantomKit"><img src="https://img.shields.io/badge/SPM-compatible-brightgreen.svg" alt="Swift Package Manager"></a>
  <a href="https://github.com/pawello2222/PhantomKit"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License"></a>
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
.package(url: "ttps://github.com/pawello2222/PhantomKit.git", .upToNextMajor(from: "1.0.0"))
```

Tip: to make PhantomKit truly _invisible_ add the below line in the main file:
```
@_exported import PhantomKit
```

## SwiftUI vs PhantomKit

#### Opening a NavigationLink on tap gesture

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

- PhantomKit
```swift
Text("Go to...")
    .link(triggeredBy: .tap, destination: Text("Destination"))
```

#### Executing an action before and after opening a NavigationLink

```swift
Text("Go to...")
    .presentation(method: .link, onTrigger: {}, onDismiss: {}) {
        Text("Destination")
    }
```

#### Opening a Web View

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
    .webView(openedAs: .link, endpoint: .feedback, edgesIgnoringSafeArea: .all) {
        print("onDismiss")
    }
```

## Overview

### Routing

Two new enums for native SwiftUI routing:

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

## Roadmap

- [x] SwiftUI
- [x] Routing
- [x] Localized formatters
- [x] Network layer
- [x] Third party ([sindresorhus/Defaults](https://github.com/sindresorhus/Defaults), [Moya/Moya](https://github.com/Moya/Moya))
- [x] SPM compatibility
- [ ] Complete documentation

## License

PhantomKit is available under the MIT license. See the [LICENSE](https://github.com/pawello2222/PhantomKit/LICENSE) file for more info.
