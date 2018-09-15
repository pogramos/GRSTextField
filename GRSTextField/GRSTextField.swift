//
//  GRSTextField.swift
//  GRSTextField
//
//  Created by Guilherme on 8/31/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit

@objc
public enum GRSTextFieldBorderType: Int {
    case left = 0
    case right
    case bottom
    case top
}

@objc @IBDesignable
public class GRSTextField: UITextField {
    @objc
    public var unmasked: String? {
        return text?.unmask()
    }

    public var errorFont: UIFont {
        get {
            if let font = errorLabel?.font {
                return font
            } else {
                return UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
            }
        }
        set (font) {
            errorLabel?.font = font
        }
    }

    @IBOutlet public var errorLabel: UILabel?

    // MARK: - IBInspectables
    @IBInspectable public var borderColor: UIColor? = .lightGray

    @IBInspectable public var errorBorderColor: UIColor? = .red

    @IBInspectable public var selectedBorderColor: UIColor? = .blue

    @objc @IBInspectable public var maskPattern: String = String.empty {
        didSet {
            if maskPattern != String.empty {
                keyboardType = .numberPad
            }
        }
    }

    @objc @IBInspectable public var hintMessage: String = String.empty

    @objc @IBInspectable public var errorMessage: String = String.empty

    @objc @IBInspectable public var maxCharacters: Int = 0

    @objc @IBInspectable public var hasBorders: Bool = false

    @objc @IBInspectable public var textInsets: CGPoint = .zero

    @objc var valid: Bool = true {
        didSet {
            updateColors()
            errorLabel?.isHidden = hintMessage.isEmpty && valid
        }
    }
    private lazy var border: CALayer? = self.makeBorder()
    private func makeBorder() -> CALayer {
        let border = CALayer()

        border.backgroundColor = borderColor?.cgColor

        return border
    }

    internal var delegateExtension: UITextFieldDelegate?
    public override var delegate: UITextFieldDelegate? {
        get {
            return super.delegate
        }
        set (newDelegate) {
            delegateExtension = newDelegate
        }
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        initialization()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization()
    }

    deinit {
        removeTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    // MARK: - Private functions

    private func initialization() {
        super.delegate = self
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        setupErrorLabel()
        if !maskPattern.isEmpty {
          keyboardType = .numberPad
        }
        layoutSubviews()
    }

    private func setupErrorLabel() {
        if errorLabel != nil && valid {
            errorLabel?.text = hintMessage
            errorLabel?.numberOfLines = 0
            errorLabel?.lineBreakMode = .byWordWrapping
            errorLabel?.isHidden = hintMessage.isEmpty
            if hintMessage.isEmpty {
                errorLabel?.textColor = errorBorderColor
            }
        }
    }

    private func addBottomLine() {
        border?.frame = CGRect(origin: CGPoint(x: bounds.origin.x, y: (bounds.maxY - 1)),
                               size: CGSize(width: bounds.width, height: 1))
        if hasBorders {
            borderStyle = .none
            guard let border = border else { return }
            guard let sublayers = layer.sublayers else { return }
            if !sublayers.contains(border) {
                layer.sublayers?.append(border)
            }
        }
    }

    internal func updateColors() {
        var color: UIColor?
        var height: CGFloat = 1
        if valid {
            if isFirstResponder {
                color = selectedBorderColor
            } else {
                color = borderColor
            }
            height = 1
        } else {
            color = errorBorderColor
            height = 3
        }
        errorLabel?.textColor = color
        border?.backgroundColor = color?.cgColor
        border?.frame.size.height = height
    }

    private func updateField(frame: CGRect) {
        self.frame = frame
        initialization()
    }

    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        textField.text = change(text: text)
    }

    // MARK: - Public functions
    public override func layoutSubviews() {
        super.layoutSubviews()
        addBottomLine()
    }

    public override func draw(_ rect: CGRect) {
        updateField(frame: CGRect(x: frame.minX,
                                  y: frame.minY,
                                  width: rect.size.width,
                                  height: rect.size.height))
    }

    @objc
    public func applyMask() {
        guard let text = text else {
            return
        }
        self.text = change(text: text)
    }

    @objc(setError:)
    public func setError(_ hasError: Bool) {
        if hasError {
            setError(errorMessage)
        } else {
            setError()
        }
    }

    @objc(setErrorWithMessage:)
    public func setError(_ message: String = "") {
        valid = message.isEmpty
        if !valid {
            errorLabel?.text = message
        } else {
            errorLabel?.text = hintMessage
        }
    }

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: textInsets.x, dy: textInsets.y)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: textInsets.x, dy: textInsets.y)
    }
}
