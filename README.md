<p align="center">
  <img src=".resources/Assets/logo.png" alt="PhantomKit logo" height=150>
</p>
<p align="center">
  <a href="https://github.com/pawello2222/PhantomKit/actions?query=branch%3Amain">
    <img src="https://img.shields.io/github/actions/workflow/status/pawello2222/PhantomKit/ci.yml?logo=github" alt="Build">
  </a>
  <a href="https://codecov.io/gh/pawello2222/PhantomKit">
    <img src="https://codecov.io/gh/pawello2222/PhantomKit/branch/main/graph/badge.svg?token=TFHOHUXCVJ" alt="Code coverage">
  </a>
  <a href="https://github.com/pawello2222/PhantomKit">
    <img src="https://img.shields.io/badge/language-swift-orange.svg" alt="Language">
  </a>
  <a href="https://github.com/pawello2222/PhantomKit#installation">
    <img src="https://img.shields.io/badge/platform-iOS%20%7C%20macOS-lightgrey.svg" alt="Supported platforms">
  </a>
</p>
<p align="center">
  <a href="https://github.com/pawello2222/PhantomKit#installation">
    <img src="https://img.shields.io/badge/SPM-compatible-brightgreen.svg" alt="Swift Package Manager">
  </a>
  <a href="https://github.com/pawello2222/PhantomKit/releases">
    <img src="https://img.shields.io/github/v/release/pawello2222/PhantomKit" alt="Release version">
  </a>
  <a href="https://github.com/pawello2222/PhantomKit/blob/main/LICENSE.md">
    <img src="https://img.shields.io/github/license/pawello2222/PhantomKit" alt="License">
  </a>
</p>

# PhantomKit

PhantomKit is a collection of many useful Swift and SwiftUI extensions and components. It is an _invisible_ layer that supports your application and makes writing Swift code easier.

<details>
  <summary>
    <b>Table of Contents</b>
  </summary>

  1. [Installation](#installation)
  2. [Swift extensions](#swift)
  3. [SwiftUI extensions](#swiftui)
  4. [Localized formatters](#formatters)
  5. [License](#license)

</details>

## Installation <a name="installation"></a>

### Requirements
* iOS 16.0+
* macOS 13.0+

### Swift Package Manager

PhantomKit is available as a Swift Package.

```swift
.package(url: "https://github.com/pawello2222/PhantomKit.git", .upToNextMajor(from: "1.0.0"))
```

### Tip

To make PhantomKit _truly invisible_ add the below line in the main file:
```swift
@_exported import PhantomKit
```

## Highlights <a name="highlights"></a>

### Swift extensions

#### Appliable

```swift
let button = UIButton().apply {
    $0.isUserInteractionEnabled = false
}
```

```swift
UserDefaults.standard.apply {
    $0.set("Value 1", forKey: "Key 1")
    $0.set("Value 2", forKey: "Key 2")
    $0.set("Value 3", forKey: "Key 3")
}
```

#### Date

```swift
let date = Date(year: 2023, month: 4, day: 1)

let newDate = date.adjusting(.minute, by: 1)
```

### SwiftUI extensions

#### Convenience methods

```swift
Text("PhantomKit")
    .fixedSize(.horizontal)
    .frame(max: .infinity)
    .onTap {
        print("PhantomKit tapped")
    }
```

#### Links

```swift
extension URL {
    static let home = URL(string: "https://tersacore.com")!
}
```
```swift
Text("Link")
    .link(url: .home, openedAs: .fullscreen)
```
```swift
Text("Link")
    .link(url: .home, openedAs: .external)
```

#### Presentation

```swift
Text("Open sheet view")
    .sheet {
        Text("Sheet view")
    }
```
```swift
Text("Open fullscreen view")
    .fullScreenCover {
        Text("Sheet view")
    }
```

#### View alignment

```swift
Text("PhantomKit")
    .alignment(horizontal: .trailing)
```

instead of:

```swift
HStack {
    Spacer()
    Text("PhantomKit")
}
```

### Localized formatters


#### Currency

```swift
let formatter = XFormatter.currency(
    locale: .init(identifier: "en_US"),
    currencyCode: "USD"
)

XCTAssertEqual(formatter.string(from: 326.097, abbreviation: .default), "$326.10")
XCTAssertEqual(formatter.string(from: 1432.99, abbreviation: .default), "$1.43k")
XCTAssertEqual(formatter.string(from: 100_081, abbreviation: .default), "$100.08k")
XCTAssertEqual(formatter.string(from: 4_729_432, abbreviation: .default), "$4.73m")
XCTAssertEqual(formatter.string(from: -42.811, abbreviation: .default), "-$42.81")
XCTAssertEqual(formatter.string(from: -4239.81, abbreviation: .default), "-$4.24k")
XCTAssertEqual(formatter.string(from: 123.456, sign: .arrow), "▲$123.46")
```

#### Decimal

```swift
let formatter = XFormatter.decimal(
    locale: .init(identifier: "en_US")
)

XCTAssertEqual(formatter.string(from: -1000), "-1,000")
XCTAssertEqual(formatter.string(from: 1000, abbreviation: .default), "1k")
XCTAssertEqual(formatter.string(from: 1000, abbreviation: .capitalized), "1K")
XCTAssertEqual(formatter.string(from: 123.456, sign: .both), "+123.46")
XCTAssertEqual(formatter.string(from: -123.456, sign: .spacedArrow), "▼ 123.46")
XCTAssertEqual(formatter.string(from: 0.123456789, precision: .default), "0.12")
XCTAssertEqual(formatter.string(from: 0.12, precision: .init(3...)), "0.120")
```

#### Date

```swift
let formatter = XDateFormatter.date(
    locale: .init(identifier: "pl_PL"),
    localizedFormat: "yyyyMMddjjmmss"
)

let date = Date(year: 2000, month: 3, day: 24, hour: 16, minute: 14, second: 44)

XCTAssertEqual(formatter.string(from: date), "24.03.2000, 16:14:44")
```

#### Date components

```swift
let formatter = XDateFormatter.dateComponents(
    locale: .init(identifier: "en_US")
)

let now = Date()
let future = now.adjusting(.day, by: 2)

XCTAssertEqual(formatter.string(from: now, to: future), "48 hours")
```

```swift
let formatter = XDateFormatter.dateComponents(
    locale: .init(identifier: "en_US")
)

let date = Date(year: 2000, month: 3, day: 24, hour: 16, minute: 14, second: 44)
let components = date.components([.hour, .minute])

XCTAssertEqual(formatter.string(from: components), "16 hours, 14 minutes")
```

## License <a name="license"></a>

PhantomKit is available under the MIT license. See the [LICENSE](./LICENSE.md) file for more info.
