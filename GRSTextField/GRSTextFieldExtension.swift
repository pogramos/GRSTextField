//
//  TextFieldDelegateHandler.swift
//  GRSTextField
//
//  Created by Guilherme on 8/31/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import Foundation

extension GRSTextField: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let textFieldShouldBeginEditing = delegateExtension?.textFieldShouldBeginEditing else {
            return true
        }
        return textFieldShouldBeginEditing(textField)
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textFieldDidBeginEditing = delegateExtension?.textFieldDidBeginEditing {
            textFieldDidBeginEditing(textField)
        }
        if let text = textField.text, !text.isEmpty {
            updateColors()
        }
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let textFieldShouldEndEditing = delegateExtension?.textFieldShouldEndEditing,
            !textFieldShouldEndEditing(textField) else {
            return true
        }
        return false
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        if let textFieldDidEndEditing = delegateExtension?.textFieldDidEndEditing(_:) {
            textFieldDidEndEditing(textField)
        }
        guard let text = textField.text else {
            setError(true)
            return
        }
        setError(text.isEmpty)
    }

    private func field(_ textField: UITextField,
                       shouldMaskInRange range: NSRange,
                       replacementString string: String) {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let newText = text.replacingCharacters(in: textRange, with: string)

            if !maskPattern.isEmpty {
                textField.text = newText.mask(pattern: maskPattern)
            } else if maxCharacters > 0 && newText.count <= maxCharacters {
                textField.text = newText
            } else {
                textField.text = newText
            }

            if let text = textField.text {
                setError(text.isEmpty)
            }
        }
    }

    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        if let functionTextField = delegateExtension?.textField(_:shouldChangeCharactersIn:replacementString:),
            !functionTextField(textField, range, string) {
            return false
        }

        field(textField, shouldMaskInRange: range, replacementString: string)

        return false
    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        guard let textFieldShouldClear = delegateExtension?.textFieldShouldClear else {
            return true
        }
        return textFieldShouldClear(textField)
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let textFieldShouldReturn = delegateExtension?.textFieldShouldReturn else {
            return true
        }
        return textFieldShouldReturn(textField)
    }
}
