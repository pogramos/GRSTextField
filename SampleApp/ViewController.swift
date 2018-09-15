//
//  ViewController.swift
//  SampleApp
//
//  Created by Guilherme on 8/30/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import UIKit
import GRSTextField

class ViewController: UIViewController {
    var textField: GRSTextField!
    var errorLabel: UILabel!
    var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configGestures()
    }

    fileprivate func setupErrorLabel(_ defaultRect: CGRect) {
        errorLabel = UILabel(frame: defaultRect)
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.numberOfLines = 0
    }

    fileprivate func setupTextField(_ defaultRect: CGRect) {
        textField = GRSTextField(frame: defaultRect)
        textField.maskPattern = "####-###"
        textField.hasBorders = true
        textField.errorMessage = "Required field"
        textField.textInsets = CGPoint(x: 12, y: 12)

        textField.errorLabel = errorLabel
    }

    func configGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        view.addGestureRecognizer(gesture)
    }

    func configUI() {
        let defaultRect = CGRect(origin: .zero, size: CGSize(width: 200, height: 40))
        setupErrorLabel(defaultRect)
        setupTextField(defaultRect)

        stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.frame.origin = CGPoint(x: view.center.x - 50, y: view.center.y - 20)

        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(errorLabel)
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.sizeToFit()

        textField.delegate = self
    }

    @objc func tap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
