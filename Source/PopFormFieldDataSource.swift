//
//  FormViewModel.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import SwiftValidator

/// The data source of all fields in a PopForm
/// Create instances that conform to this protocol and use them to create an instance of *PopForm_Datasource* for PopForm_ViewController's ViewModel
protocol PopFormFieldDataSource {

  init()

  /// The Field's Theme
  var theme: PopFormFieldTheme { get }

  /// The Placeholder's Text for the field
  var placeholder: String { get set }

  /// The ValidationRule's of the field. Set to nil for optional fields
  /// - Remark: default is *[RequiredRule()]*
  var validationRule: [Rule]? { get set }

  /// The Keyboard type that should be presented when the field becomes first responder.
  /// - Remark: default is *.default*
  var keyboardType: UIKeyboardType { get }

  /// an api key for the field MUST BE UNIQUE TO EACH FIELD ON A SINGLE FORM
  /// otherwise the cell will deque and not store the field's entered text
  var apiKey: String { get }

  /// Set for autoCorrection
  /// - Remark: default is *UITextAutocorrectionType.no*
  var hasAutoCorrection: UITextAutocorrectionType { get }

  /// Set for prefilled data
  /// - Remark: Will fill if you set the swift flag -DDEBUG_PopFORM
  var stockData: String { get }

  /// If the field should have secure entry
  /// - Remark: default is *false*
  var isSecureEntry: Bool { get }

  /// The return key type for the field.
  /// - Remark: default is UIReturnKeyType.default
  var returnKey: UIReturnKeyType? { get set }

  /// The Capitilization of the textfield defaults to .none
  var autoCapitilization: UITextAutocapitalizationType { get }

  /// If not nil will set the input of the textField to a datePicker
  var datePickerWithDataSource: PopFormDatePickerDataSource? { get }

  /// If not nil will set the input of the textField to a custom pickerView
  var pickerViewWithDataSource: PopFormPickerViewDataSource? { get }

  /// the selection style of the cell
  var selectionStyle: UITableViewCell.SelectionStyle { get }

  /// set this when unwinding from another screen
  var prefilledText: String? { get set }

  /// the contentType of form field's textField
  var hasContentType: UITextContentType? { get }

  /// set this to use a UITextView instead of a UITextField for the form's field
  var isTextView: Bool { get }
}


extension PopFormFieldDataSource {

  var keyboardType: UIKeyboardType { return .default }

  var hasAutoCorrection: UITextAutocorrectionType { return .no }

  var isSecureEntry: Bool { return false }

  var stockData: String { return "" }

  var autoCapitilization: UITextAutocapitalizationType { return .none }

  var datePickerWithDataSource: PopFormDatePickerDataSource? { return nil }

  var pickerViewWithDataSource: PopFormPickerViewDataSource? { return nil }

  var selectionStyle: UITableViewCell.SelectionStyle { return UITableViewCell.SelectionStyle.none }

  var hasContentType: UITextContentType? { return nil }

  var isTextView: Bool { return false }
}


extension PopFormFieldDataSource {
  init(prefilledText: String?, validationRules: [Rule], returnKey: UIReturnKeyType){
    self.init(validationRules: validationRules, returnKey: returnKey)
    self.prefilledText = prefilledText
  }

  init(returnKey: UIReturnKeyType){
    self.init()
    self.returnKey = returnKey
  }

  init(placeholder: String, returnKey: UIReturnKeyType, validationRules: [Rule]){
    self.init(validationRules: validationRules, returnKey: returnKey)
    self.placeholder = placeholder
  }

  init(validationRules: [Rule], returnKey: UIReturnKeyType){
    self.init(returnKey: returnKey)
    self.validationRule = validationRules
  }
}
