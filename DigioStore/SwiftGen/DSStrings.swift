// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum DSStrings {
  /// digio Cash
  internal static let digioCash = DSStrings.tr("Localizable", "digioCash", fallback: "digio Cash")
  /// Digio Store
  internal static let digioStore = DSStrings.tr("Localizable", "digioStore", fallback: "Digio Store")
  /// Nenhum dado encontrado
  internal static let emptyData = DSStrings.tr("Localizable", "emptyData", fallback: "Nenhum dado encontrado")
  /// Erro
  internal static let error = DSStrings.tr("Localizable", "error", fallback: "Erro")
  /// Erro no parse
  internal static let parserError = DSStrings.tr("Localizable", "parserError", fallback: "Erro no parse")
  /// Produtos
  internal static let products = DSStrings.tr("Localizable", "products", fallback: "Produtos")
  /// Desculpe, algo de errado aconteceu
  internal static let somethingWrong = DSStrings.tr("Localizable", "somethingWrong", fallback: "Desculpe, algo de errado aconteceu")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension DSStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
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
