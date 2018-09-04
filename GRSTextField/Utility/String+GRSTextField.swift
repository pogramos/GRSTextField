//
//  GRSTextField+Extension.swift
//  GRSTextField
//
//  Created by Guilherme on 8/30/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

extension String {

    static var empty: String {
        return ""
    }

    subscript(indice: Int) -> String {
        return String(self[index(startIndex, offsetBy: indice)])
    }

    func localized(_ table: String = "Localizable") -> String {
        return Bundle.main.localizedString(forKey: self, value: self, table: table)
    }

    /// Applies a pattern to the string input on the text field.
    ///
    /// ## Masking your text:
    ///
    ///         let textField = GRTextField()
    ///         textField.text = "1111222"
    ///         let text = textField.mask(pattern: "####-###")
    ///
    /// considering the case shown above, the text would be equal to 1111-222
    ///
    /// - Parameter pattern: Mask pattern to transform the field
    /// - Returns: string modified by the pattern
    func mask(pattern: String) -> String {
        var index = 0
        var masked = String.empty
        let raw = unmask()
        // iterate over the mask pattern
        for character in pattern {
            if index >= raw.count { break }
            // get the current character and compare it to the number mask
            let replacement = String(character)
            // if the mask matches the number pattern, replaces it with the string at
            // n index position
            if replacement == "#" {
                masked.append(raw[index])
                index += 1
            } else {
                // otherwise just replace the current string with the mask pattern
                masked.append(replacement)
            }
        }
        return masked
    }

    /// Removes the mask pattern from the input text of the field
    ///
    /// - Returns: Returns the raw string without the mask pattern (considering only digits)
    func unmask() -> String {
        var raw = String.empty
        for character in self {
            let charSet = CharacterSet(charactersIn: String(character))
            if charSet.isSubset(of: .decimalDigits) {
                raw.append(character)
            }
        }
        return raw
    }
}
