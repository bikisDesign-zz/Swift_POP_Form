//
//  PopFormTheme.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

/// the theme for a form field
/// - Remark: Can be used for UITextField or UITextView fields
protocol PopFormFieldTheme {

  /// the backgroundColor of the field
  var backgroundColor: UIColor { get }

  /// the color of the field's text
  var textColor: UIColor { get }

  /// the font of the field's text
  var textfieldFont: UIFont { get }

  /// the font of the field's placeHolder text
  var placeholderTextColor: UIColor { get }

  /// the height of the field's content if a UITextField
  var textFieldHeight: CGFloat { get }

  /// the height of the field's content if a UITextView
  var textViewHeight: CGFloat { get }

  /// the color of the field's border
  var borderColor: UIColor { get }

  /// the width of the field's border
  var borderWidth: CGFloat { get }

  /// the opacity of the field's border
  var borderOpacity: Float { get }

  /// the alignment of the field's text
  var textAlignment: NSTextAlignment { get }

  /// the color of the error's text to be shown to a user when the field's validation fails
  var errorColor: UIColor { get }

  /// the color of the textfield's text when the field is selected
  var focusedColor: UIColor { get }

  /// the color of the textfield's cursor when the field is selected
  var cursorColor: UIColor { get }
}



