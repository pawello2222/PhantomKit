// The MIT License (MIT)
//
// Copyright (c) 2021-Present Paweł Wiszenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

extension Bundle {
    /// The name of the executable in this bundle (if any).
    public var executable: String {
        info(forKey: kCFBundleExecutableKey)
    }

    /// The bundle identifier.
    public var identifier: String {
        info(forKey: kCFBundleIdentifierKey)
    }

    /// The version number of the bundle (e.g., `"1.0"`).
    public var versionNumber: String {
        info(forKey: "CFBundleShortVersionString")
    }

    /// The build number of the bundle (e.g., `"300"`).
    public var buildNumber: String {
        info(forKey: kCFBundleVersionKey)
    }

    /// The version and build number of the bundle (e.g., `"1.0 (300)"`).
    public var versionBuildNumber: String {
        "\(versionNumber) (\(buildNumber))"
    }
}

// MARK: - Private

extension Bundle {
    private func info(forKey key: String) -> String {
        infoDictionary?[key] as? String ?? ""
    }

    private func info(forKey key: CFString) -> String {
        info(forKey: key as String)
    }
}
