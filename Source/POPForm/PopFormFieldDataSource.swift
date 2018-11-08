//
//  FormViewModel.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

typealias Credentials = [String: String]

/// The data source of all fields in a PopForm
/// Create instances that conform to this protocol and use them to create an instance of *PopForm_Datasource* for PopForm_ViewController's ViewModel
protocol PopFormFieldDataSource {
  
  /// The Field's Theme
  var theme: PopFormFieldTheme { get }
  
  /// The Placeholder's Text for the field
  var placeholder: String { get }
  
  /// The ValidationRule's of the field. Set to nil for optional fields
  /// - Remark: default is *[RequiredRule()]*
  var validationRule: [Rule]? { get }
  
  /// The Keyboard type that should be presented when the field becomes first responder.
  /// - Remark: default is *.default*
  var keyboardType: UIKeyboardType { get }
  
  /// an api key for the field MUST BE UNIQUE TO EACH FIELD ON A SINGLE FORM
  /// otherwise the cell will deque and not store the field's entered text
  var apiKey: String { get }
  
  /// Set for autoCorrection
  /// - Remark: default is *.no*
  var hasAutoCorrection: UITextAutocorrectionType { get }
  
  /// Set for prefilled data
  /// Will fill if you set the swift flag -DDEBUG_PopFORM
  var stockData: String { get }
  
  /// If the field should have secure entry
  /// - Remark: default is *false*
  var isSecureEntry: Bool { get }
  
  /// The return key type for the field.
  /// - Remark: default is .default
  var returnKey: UIReturnKeyType { get }

  /// If not nil will create an icon on the left side
  var fieldIcon: UIImage? { get }
  
  /// The Capitilization of the textfield defaults to .none
  var autoCapitilization: UITextAutocapitalizationType { get }
  
  var helperText: String? { get }
  
  var datePickerWithStartDate: Date? { get }
  
  var pickerViewWithDataSource: PopFormPickerViewDataSource? { get }
}


extension PopFormFieldDataSource {
  
  var keyboardType: UIKeyboardType { return .default }
  
  var validationRule: [Rule]? { return [RequiredRule()] }
  
  var hasAutoCorrection: UITextAutocorrectionType { return .no }
  
  var isSecureEntry: Bool { return false }
  
  var stockData: String { return "" }
  
  var returnKey: UIReturnKeyType { return UIReturnKeyType.default }

  var fieldIcon: UIImage? { return nil }

  var autoCapitilization: UITextAutocapitalizationType { return .none }
  
  var helperText: String? { return nil }
  
  var datePickerWithStartDate: Date? { return nil }
  
  var pickerViewWithDataSource: PopFormPickerViewDataSource? { return nil }
}
