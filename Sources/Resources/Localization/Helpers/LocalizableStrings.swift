// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localized {
  /// Cancel
  internal static let cancel = Localized.tr("Localizable", "cancel")
  /// Done
  internal static let done = Localized.tr("Localizable", "done")

  internal enum About {
    /// App Design
    internal static let appDesign = Localized.tr("Localizable", "about.app_design")
    /// Graphics
    internal static let graphics = Localized.tr("Localizable", "about.graphics")
  }

  internal enum LastUpdated {
    /// Last updated: %@
    internal static func lastUpdated(_ p1: Any) -> String {
      return Localized.tr("Localizable", "last_updated.last_updated", String(describing: p1))
    }
    /// Never
    internal static let never = Localized.tr("Localizable", "last_updated.never")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localized {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
