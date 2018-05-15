//
//  LocalFormDataSource.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import RP_iosBootstrap

struct LocalFormDataSource: PopForm_DataSource {
  var fields: PopForm_Fields = [FirstNameField(),
                                LastNameField(),
                                PasswordField()]
  
  var theme: PopForm_Theme = FormTheme()
}

private struct FormTheme: PopForm_Theme {
  var backgroundColor: UIColor = UIColor(r: 64, g: 196, b: 255)
  var formColor: UIColor = UIColor(r: 130, g: 247, b: 255)
}



private struct TextFieldTheme: PopForm_FieldTheme {
  var backgroundColor: UIColor = UIColor.white
  
  var textColor: UIColor = UIColor.black
  
  var placeholderTextColor: UIColor = UIColor.lightText
  
  var borderColor: UIColor = UIColor.lightGray
  
  var borderWidth: CGFloat = 0.5
  
  var height: CGFloat = 65
}


private struct FirstNameField: PopForm_FieldDataSource {
  var theme: PopForm_FieldTheme = TextFieldTheme()
  var apiKey: String = "first_name"
  var placeholder: String = "First Name"
  var validationRule: [Rule]? = [AlphaRule()]
}

private struct LastNameField: PopForm_FieldDataSource {
  var theme: PopForm_FieldTheme = TextFieldTheme()
  var apiKey: String = "last_name"
  var placeholder: String = "Last Name"
}

private struct PasswordField: PopForm_FieldDataSource {
  var theme: PopForm_FieldTheme = TextFieldTheme()
  var apiKey: String = "password"
  var placeholder: String = "Password"
  var validationRule: [Rule]? = [PasswordRule()]
  var isSecureEntry: Bool = true
}

