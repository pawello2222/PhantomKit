// The MIT License (MIT)
//
// Copyright (c) 2024-Present Paweł Wiszenko
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

import SwiftUI
import XCTest
@testable import PhantomKitUI

class ColorTests: XCTestCase {
    override func setUpWithError() throws {}
}

// MARK: - Tests: Convenience

extension ColorTests {
    func test_initWithHex() throws {
        let accuracy = 0.01
        let color = Color(hex: 0xBF7F3F, opacity: 1)
        XCTAssertEqual(color.components.red, 0.75, accuracy: accuracy)
        XCTAssertEqual(color.components.green, 0.5, accuracy: accuracy)
        XCTAssertEqual(color.components.blue, 0.25, accuracy: accuracy)
        XCTAssertEqual(color.components.alpha, 1, accuracy: accuracy)
    }
}
