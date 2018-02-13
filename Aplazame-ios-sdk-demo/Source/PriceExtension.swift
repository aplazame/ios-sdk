import UIKit

extension String {
    static func formatted(price priceInCents: Int, locale: Locale) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        let amount = Double(priceInCents) * Double(0.01)
        return formatter.string(from: NSNumber(value: amount))!
    }
}
