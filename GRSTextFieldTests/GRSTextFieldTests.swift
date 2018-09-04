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
    var textField: GRSTextField!

    override func setUp() {
        textField = GRSTextField()
        super.setUp()
    }

    private func mask() {
        textField.maskPattern = "####-###"
        textField.text = "1111222"
        textField.applyMask()
    }

    func testMask() {
        mask()
        let expected = "1111-222"

        XCTAssertEqual(textField.text, expected)
    }

    func testUnmask() {
        mask()
        let expected = "1111222"

        XCTAssertEqual(textField.unmasked, expected)
    }

    func testKeyboardType() {
        textField.maskPattern = "#"
        let expected: UIKeyboardType = .numberPad
        XCTAssertEqual(textField.keyboardType, expected)
    }

    func testColors() {
        let borderColorExpected: UIColor = .lightGray
        let selectedColorExpected: UIColor = .blue
        let errorBorderColorExpected: UIColor = .red
        XCTAssertEqual(textField.borderColor, borderColorExpected)
        XCTAssertEqual(textField.selectedBorderColor, selectedColorExpected)
        XCTAssertEqual(textField.errorBorderColor, errorBorderColorExpected)
    }
}
