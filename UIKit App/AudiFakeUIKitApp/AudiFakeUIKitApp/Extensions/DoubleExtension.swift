import Foundation

extension Double {
    func currencyFormatted() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        guard let formattedString = formatter.string(from: self as NSNumber) else { return nil }
        return formattedString
    }
    
}
