import SwiftUI
import UIKit

// MARK: - Font

extension UIFont {

    /// Workout card title font
    public static var title: UIFont = .init(name: .graphikMedium, size: 14)!

    /// Workout card detail and rounds font
    public static var detail: UIFont = .init(name: .graphikRegular, size: 12)!

    /// Workout card tag font
    public static var tag: UIFont = .init(name: .graphikRegular, size: 10)!
}

// MARK: - Fonts

extension Font {

    public static var title: Font {

        #if DEBUG
        if ProcessInfo.isPreview {

            return .system(size: 14, weight: .bold, design: .default)
        }
        #endif

        return Font.custom(.graphikMedium, size: 14)
    }

    /// Package description label & package accessories label & price title label
    public static var detail: Font {

        #if DEBUG
        if ProcessInfo.isPreview {

            return .system(size: 12, weight: .regular, design: .default)
        }
        #endif

        return Font.custom(.graphikRegular, size: 12)
    }

    /// Price label font
    public static var tag: Font {

        #if DEBUG
        if ProcessInfo.isPreview {

            return .system(size: 10, weight: .regular, design: .default)
        }
        #endif

        return Font.custom(.graphikRegular, size: 10)
    }
}

// MARK: - Font names

extension String {

    fileprivate static let graphikMedium: String = "Graphik-Medium"
    fileprivate static let graphikRegular: String = "Graphik-Regular"
}

extension ProcessInfo {

    static var isPreview: Bool {

        processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
