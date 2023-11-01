import SwiftUI
import UIKit

// MARK: - UIColors

extension UIColor {

    public static var brandRed: UIColor = .init(hex: "#D73C4B")
    public static var brandRedTint: UIColor = .init(hex: "#EB7580")
    public static var brandBlue: UIColor = .init(hex: "#0F1E3C")
    public static var brandBlueTint: UIColor = .init(hex: "#27344F")
    public static var brandGray0: UIColor = .init(hex: "#EDF0F2")
    public static var brandGray1: UIColor = .init(hex: "#DDDFE1")
    public static var brandGray2: UIColor = .init(hex: "#B4B9BE")
    public static var brandGray3: UIColor = .init(hex: "#91989E")
    public static var brandGray4: UIColor = .init(hex: "#4F555C")
    public static var brandGray5: UIColor = .init(hex: "#31363B")
    public static var brandGray6: UIColor = .init(hex: "#14171A")
    public static var accentBlue: UIColor = .init(hex: "#67ADFF")
    public static var accentGold: UIColor = .init(hex: "#F5A623")
    public static var accentMagenta: UIColor = .init(hex: "#C056CF")
    public static var accentAqua: UIColor = .init(hex: "#50E3C2")
}

// MARK: - Utility

extension UIColor {

    /// Initialize a color according to the hexadecimal string value
    /// - Parameters:
    ///     - hex: string representing the color in hexadecimal format
    ///     - alpha: alpha value of the color to be generated
    /// - Note: the hexadecimal string must be valid (including `#` and `6` hexadecimal digits
    public convenience init(hex: String, alpha: CGFloat = 1) {

        guard hex.hasPrefix("#") else { fatalError() }

        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])

        guard hexColor.count == 6 else { fatalError() }

        let scanner = Scanner(string: hexColor)

        var hexNumber: UInt64 = 0

        guard scanner.scanHexInt64(&hexNumber) else { fatalError() }

        let r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
        let g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
        let b = CGFloat((hexNumber & 0x0000FF) >> 0) / 255

        self.init(displayP3Red: r, green: g, blue: b, alpha: alpha)
    }

    /// Generate a dynamic color that changes according to the operating system dark/light mode
    /// - Parameters:
    ///     - light: color for light mode
    ///     - dark: color for dark mode
    /// - Returns: dynamic color
    public class func dynamicColor(
        light: UIColor,
        dark: UIColor) -> UIColor {

        return UIColor {
            switch $0.userInterfaceStyle {
            case .dark: return dark
            default: return light
            }
        }
    }
}

// MARK: - Colors

extension Color {

    public static var brandRed: Color = .init(hex: "#D73C4B")
    public static var brandRedTint: Color = .init(hex: "#EB7580")
    public static var brandBlue: Color = .init(hex: "#0F1E3C")
    public static var brandBlueTint: Color = .init(hex: "#27344F")
    public static var brandGray0: Color = .init(hex: "#EDF0F2")
    public static var brandGray1: Color = .init(hex: "#DDDFE1")
    public static var brandGray2: Color = .init(hex: "#B4B9BE")
    public static var brandGray3: Color = .init(hex: "#91989E")
    public static var brandGray4: Color = .init(hex: "#4F555C")
    public static var brandGray5: Color = .init(hex: "#31363B")
    public static var brandGray6: Color = .init(hex: "#14171A")
    public static var accentBlue: Color = .init(hex: "#67ADFF")
    public static var accentGold: Color = .init(hex: "#F5A623")
    public static var accentMagenta: Color = .init(hex: "#C056CF")
    public static var accentAqua: Color = .init(hex: "#50E3C2")
}

// MARK: - Utility

extension Color {

    /// Initialize a color according to the hexadecimal string value
    /// - Parameters:
    ///     - hex: string representing the color in hexadecimal format
    ///     - alpha: alpha value of the color to be generated
    /// - Note: the hexadecimal string must be valid (including `#` and `6` hexadecimal digits
    public init(hex: String, alpha: CGFloat = 1) {

        guard hex.hasPrefix("#") else { fatalError() }

        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])

        guard hexColor.count == 6 else { fatalError() }

        let scanner = Scanner(string: hexColor)

        var hexNumber: UInt64 = 0

        guard scanner.scanHexInt64(&hexNumber) else { fatalError() }

        let r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
        let g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
        let b = CGFloat((hexNumber & 0x0000FF) >> 0) / 255

        self.init(.displayP3, red: r, green: g, blue: b, opacity: alpha)
    }

    public static func dynamic(
        light lightModeColor: @escaping @autoclosure () -> Color,
        dark darkModeColor: @escaping @autoclosure () -> Color) -> Color {

        self.init(UIColor(
            light: UIColor(color: lightModeColor()),
            dark: UIColor(color: darkModeColor())))
    }
}

extension UIColor {

    /// Initialize a color using two closures, each returning `UIColor`
    /// This is used by `Color.dynamic` to glean traitCollection from
    /// `UIColor` that isn't available to `Color`
    fileprivate convenience init(
        light lightModeColor: @escaping @autoclosure () -> UIColor,
        dark darkModeColor: @escaping @autoclosure () -> UIColor) {

        self.init { traitCollection in

            switch traitCollection.userInterfaceStyle {

            case .light, .unspecified: return lightModeColor()
            case .dark: return darkModeColor()
            @unknown default: return lightModeColor()
            }
        }
    }

    public convenience init(color: Color) { self.init(color) }
}
