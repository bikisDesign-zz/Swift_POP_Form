//
//  Swift_POP_FormUITests.swift
//  Swift_POP_FormUITests
//
//  Created by Dev Bikis on 7/16/19.
//  Copyright © 2019 Aaron bikis. All rights reserved.
//

import XCTest
@testable import Swift_POP_Form

class Swift_POP_FormUITests: XCTestCase {
  var validationFailureText: Set<String>!


  override func setUp() {
    super.setUp()
    validationFailureText = ["Invalid US ZIP Code", "Invalid US Phone Number", "Must be 18 or older", "First Name is Required"]
    continueAfterFailure = false
    XCUIApplication().launch()
  }

  override func tearDown() {
    validationFailureText = nil
  }

  func testFailedValidation(){
    // given
    let validateButton = XCUIApplication().navigationBars.buttons["Validate"]
    // when
    validateButton.tap()

    for text in validationFailureText {
      let label = XCUIApplication().staticTexts[text]

      // then
      if label.waitForExistence(timeout: 1) == false {
        XCTFail("element doesn't exist for text \(text)")
      }
    }
  }

  func testEnteringText(){
    // given
    let tableView = XCUIApplication().tables.element
    for element in XCUIApplication().textFields.allElementsBoundByIndex {
      // when
      switch element.value as? String {
      case .none:
        break
      case "First Name":
        element.tap()
        element.typeText("My First Name")

      case "Last Name":
        element.tap()
        element.typeText("My Last Name")

      case "ZIP":
        tableView.swipeUp()
        element.tap()
        element.typeText("97202")

      case "Phone Number":
        element.tap()
        element.typeText("1234567890")

      case "Occupation":
        element.tap()
        let pickerWheelElement = XCUIApplication().pickerWheels.element
        pickerWheelElement.adjust(toPickerWheelValue: "iOS Developer")
        pickerWheelElement.adjust(toPickerWheelValue: "Student")
        pickerWheelElement.adjust(toPickerWheelValue: "Professional Wrestler")
        
      case "Birthday":
        tableView.swipeUp()
        testBirthdayPickerChange()      

      default:
        XCTFail("unsupported text field being tested \(element.value!)")
      }
    }
    // then
    XCUIApplication().navigationBars.buttons["Validate"].tap()
    XCTAssert(XCUIApplication().staticTexts["All Fields Done Gone Valid"].waitForExistence(timeout: 2))
  }

  func testBirthdayPickerChange(){
    XCUIApplication().textFields["Birthday"].tap()
    let datePicker = XCUIApplication().pickerWheels
    datePicker.element(boundBy: 0).adjust(toPickerWheelValue: "July")
    datePicker.element(boundBy: 1).adjust(toPickerWheelValue: "4")
    datePicker.element(boundBy: 2).adjust(toPickerWheelValue: "1989")
  }
}
