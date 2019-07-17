//
//  XCUIElement-Ext.swift
//  Swift_POP_FormUITests
//
//  Created by Dev Bikis on 7/16/19.
//  Copyright © 2019 Aaron bikis. All rights reserved.
//

import XCTest
extension XCUIElement {

  func scrollToElement(element: XCUIElement) {
    while !element.visible() {
      swipeUp()
    }
  }

  func visible() -> Bool {
    guard self.exists && !self.frame.isEmpty else { return false }
    return true
  }

}
