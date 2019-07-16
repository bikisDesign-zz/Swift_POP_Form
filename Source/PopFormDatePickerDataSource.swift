//
//  PopFormDatePickerViewDataSource.swift
//  Swift_POP_Form
//
//  Created by Dev Bikis on 7/16/19.
//  Copyright © 2019 Aaron bikis. All rights reserved.
//

import Foundation

/// The Datasource passed to a field containing a date picker
/// Contains a StartDate, dateRange and shouldPrefillStartDate
protocol PopFormDatePickerDataSource {

  /// the start date that the pickerView will be set to
  /// leave nil to set it to todays date
  var startDate: Date? { get }

  /// the date range to restrict the date picker to
  /// leave as nil to not restrict it
  var restrictedDateRange: (Date, Date)? { get }

  /// will set the textfield's text on load instead of on didbeginediting
  var shouldPrefillStartDate: Bool { get }
  
  /// how the displayed date should be formatted
  var formatForDisplayedDate: (Date) -> String { get }
}

