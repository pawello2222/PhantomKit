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

#if os(iOS) || os(tvOS) || os(watchOS)
private typealias PlatformColor = UIColor
#elseif os(macOS)
private typealias PlatformColor = NSColor
#endif

// MARK: - Components

extension Color {
    // swiftlint:disable:next large_tuple
    public var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        PlatformColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}

// MARK: - Conformance

extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case red, green, blue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let red = try container.decode(Double.self, forKey: .red)
        let green = try container.decode(Double.self, forKey: .green)
        let blue = try container.decode(Double.self, forKey: .blue)
        self.init(red: red, green: green, blue: blue)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(components.red, forKey: .red)
        try container.encode(components.green, forKey: .green)
        try container.encode(components.blue, forKey: .blue)
    }
}

// MARK: - Convenience

extension Color {
    /// Creates a constant color from a hexadecimal value (`0xRRGGBB`).
    public init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: .init((hex >> 16) & 0xFF) / 255,
            green: .init((hex >> 08) & 0xFF) / 255,
            blue: .init((hex >> 00) & 0xFF) / 255,
            opacity: opacity
        )
    }
}

extension Color {
    /// Returns a random color with the given alpha.
    public static func random(alpha: CGFloat = 1) -> Color {
        let red: CGFloat = .random(in: 0 ... 1)
        let green: CGFloat = .random(in: 0 ... 1)
        let blue: CGFloat = .random(in: 0 ... 1)
        return .init(CGColor(red: red, green: green, blue: blue, alpha: alpha))
    }
}
