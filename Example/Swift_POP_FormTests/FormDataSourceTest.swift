//
//  Swift_POP_FormTests.swift
//  Swift_POP_FormTests
//
//  Created by Dev Bikis on 7/16/19.
//  Copyright © 2019 Aaron bikis. All rights reserved.
//

import XCTest

@testable import Swift_POP_Form

class FormDataSourceTest: XCTestCase {

  var sut: LocalFormDataSource!
  var now: Date!
  var dateFormatter: DateFormatter!

  override func setUp() {
    super.setUp()
    sut = LocalFormDataSource()
    now = Calendar.current.startOfDay(for: Date())
    dateFormatter = DateFormatter()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func testBirthdayField(){
    // given
    guard let birthDayField = sut.fields.first(where: { $0.apiKey == "birthday" })
      else { XCTFail("birthday field is not contained in the fields array or the api key has changed"); return }
    guard birthDayField.datePickerWithDataSource != nil
      else { XCTFail("birthday field does not have a date picker data source"); return }

    // when
    let currentDate = birthDayField.datePickerWithDataSource!.formatForDisplayedDate(now)

    // then
    dateFormatter.dateFormat = "dd.MM.yy"

    guard let dateToMatch = dateFormatter.date(from: currentDate)
      else { XCTFail("dateFormatter didn't create a date"); return }

    XCTAssert(dateToMatch == now, "entered date doesn't match today's date, today:\(String(describing: now)), dateToMatch:\(dateToMatch)")
  }
}
