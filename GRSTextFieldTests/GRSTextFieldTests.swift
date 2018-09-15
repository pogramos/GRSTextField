//
//  GRSTextFieldTests.swift
//  GRSTextFieldTests
//
//  Created by Guilherme on 8/31/18.
//  Copyright © 2018 Progeekt. All rights reserved.
//

import XCTest
@testable import GRSTextField

class GRSTextFieldTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    func testMask() {
        let textField = GRSTextField()
        textField.maskPattern = "####-###"
        textField.text = "1111222"
        textField.applyMask()
        let expected = "1111-222"
        XCTAssertEqual(textField.text, expected)
    }

    func testUnmask() {
        let textField = GRSTextField()
        textField.maskPattern = "####-###"
        textField.text = "1111222"
        textField.applyMask()
        let expected = "1111222"
        XCTAssertEqual(textField.unmasked, expected)
    }

    func testKeyboardType() {
        let textField = GRSTextField()
        textField.maskPattern = "#"
        let expected: UIKeyboardType = .numberPad
        XCTAssertEqual(textField.keyboardType, expected)
    }

    func testValidate() {
        let textField = GRSTextField()
        textField.maxCharacters = 2
        textField.text = "1234567"
        textField.sendActions(for: .editingChanged)
        let expected = "12"
        XCTAssertEqual(textField.text, expected)
    }

    func testColors() {
        let textField = GRSTextField()
        let borderColorExpected: UIColor = .lightGray
        let selectedColorExpected: UIColor = .blue
        let errorBorderColorExpected: UIColor = .red
        XCTAssertEqual(textField.borderColor, borderColorExpected)
        XCTAssertEqual(textField.selectedBorderColor, selectedColorExpected)
        XCTAssertEqual(textField.errorBorderColor, errorBorderColorExpected)
    }
}
