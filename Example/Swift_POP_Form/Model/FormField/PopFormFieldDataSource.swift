//
//  FormViewModel.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

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
  
  /// Any apiKeys that you'd like to be associated with the field to process once the field has been validated
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
}


extension PopFormFieldDataSource {
  
  var keyboardType: UIKeyboardType { return .default }
  
  var validationRule: [Rule]? { return [RequiredRule()] }
  
  var hasAutoCorrection: UITextAutocorrectionType { return .no }
  
  var isSecureEntry: Bool { return false }
  
  var stockData: String { return "" }
  
  var returnKey: UIReturnKeyType { return UIReturnKeyType.default }
}
