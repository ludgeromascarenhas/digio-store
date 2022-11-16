import UIKit

// MARK: - NSMutableAttributedStringExtensions

extension NSMutableAttributedString {

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute,
                                                      options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor,
                          value: color,
                          range: range)
    }
}
