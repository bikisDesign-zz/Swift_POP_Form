//
//  Swift_POP_FormUITests.swift
//  Swift_POP_FormUITests
//
//  Created by Dev Bikis on 7/16/19.
//  Copyright © 2019 Aaron bikis. All rights reserved.
//

import XCTest

class Swift_POP_FormUITests: XCTestCase {

  override func setUp() {
    super.setUp()

    continueAfterFailure = false
    XCUIApplication().launch()

  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testScroll(){
    let app = XCUIApplication()
    app.navigationBars.buttons
  }

}
