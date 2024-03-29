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
    <img src="https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-lightgrey.svg" alt="Supported platforms">
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
  2. [Highlights](#highlights)
  3. [License](#license)

</details>

## Installation <a name="installation"></a>

### Requirements
* iOS 16.0+
* macOS 13.0+
* watchOS 9.0+
* tvOS 16.0+

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
let date = Date(year: 2000, month: 1, day: 2, hour: 3, minute: 4, second: 5)

XCTAssertEqual(date.adjusting(\.second, by: 1).component(.second), 6)
XCTAssertEqual(date.adjusting(\.minute, by: 1).component(.minute), 5)
XCTAssertEqual(date.adjusting(\.hour, by: 1).component(.hour), 4)
XCTAssertEqual(date.adjusting(\.day, by: 1).component(.day), 3)
XCTAssertEqual(date.adjusting(\.month, by: 1).component(.month), 2)
XCTAssertEqual(date.adjusting(\.year, by: 1).component(.year), 2001)
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

## License <a name="license"></a>

PhantomKit is available under the MIT license. See the [LICENSE](./LICENSE.md) file for more info.
