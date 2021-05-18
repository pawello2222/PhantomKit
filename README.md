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

- From Xcode:

    `File` -> `Swift Packages` -> `Add Package Dependency...` -> `https://github.com/pawello2222/PhantomKit.git`

- From SPM:

```swift
.package(url: "ttps://github.com/pawello2222/PhantomKit.git", .upToNextMajor(from: "1.0.0"))
```

### Import

Add the below import at the top of your file:
```
import PhantomKit
```

To make PhantomKit truly _invisible_ add the below line in the main file:
```
@_exported import PhantomKit
```

## License

PhantomKit is available under the MIT license. See the [LICENSE](https://github.com/pawello2222/PhantomKit/LICENSE) file for more info.
