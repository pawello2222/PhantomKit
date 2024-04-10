// The MIT License (MIT)
//
// Copyright (c) 2023-Present Paweł Wiszenko
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

class LogBuilder {
    enum Options {
        case none
        case tag
    }

    private var separator = ""
    private var items: [String] = []

    @discardableResult
    func append(date: Date, options: Options = .none) -> Self {
        let formattedDate = Self.dateFormatter.string(from: .now)
        items.append(formattedDate.with(options: options))
        return self
    }

    @discardableResult
    func append(string: String?, options: Options = .none) -> Self {
        guard let string else {
            return self
        }
        items.append(string.with(options: options))
        return self
    }

    @discardableResult
    func separate(by separator: String) -> Self {
        self.separator = separator
        return self
    }

    func build() -> String {
        items.joined(separator: separator)
    }
}

// MARK: - Helpers

extension LogBuilder {
    private static var dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
}

extension String {
    fileprivate func with(options: LogBuilder.Options) -> Self {
        switch options {
        case .none:
            return self
        case .tag:
            return "[\(self)]"
        }
    }
}
