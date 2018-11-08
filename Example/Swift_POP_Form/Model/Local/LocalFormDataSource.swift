//
//  LocalFormDataSource.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit


struct LocalFormDataSource: PopFormDataSource {
  var fields: PopFormFields = [FirstNameField(),
                                LastNameField(),
                                PasswordField()]
  
  var theme: PopFormTheme = FormTheme()
}


private struct FormTheme: PopFormTheme {
  var backgroundColor: UIColor = .white
  var formColor: UIColor = .white
}



private struct TextFieldTheme: PopFormFieldTheme {
  var textfieldFont: UIFont = UIFont.systemFont(ofSize: 15)
  
  var borderOpacity: Float = 0.85
  
  var textAlignment: NSTextAlignment = .center
  
  var borderIsUnderline: Bool = false
  
  var errorColor: UIColor = .red
  
  var backgroundColor: UIColor = UIColor.white
  
  var textColor: UIColor = UIColor.black
  
  var placeholderTextColor: UIColor = UIColor.lightText
  
  var borderColor: UIColor = UIColor.lightGray
  
  var borderWidth: CGFloat = 0.5
  
  var height: CGFloat = 65
}



private struct FirstNameField: PopFormFieldDataSource {
  var theme: PopFormFieldTheme = TextFieldTheme()
  var apiKey: String = "first_name"
  var placeholder: String = "First Name"
  var validationRule: [Rule]? = [AlphaRule()]
  var returnKey: UIReturnKeyType = UIReturnKeyType.next
}


private struct LastNameField: PopFormFieldDataSource {
  var theme: PopFormFieldTheme = TextFieldTheme()
  var apiKey: String = "last_name"
  var placeholder: String = "Last Name"
  var returnKey: UIReturnKeyType = UIReturnKeyType.next
}


private struct PasswordField: PopFormFieldDataSource {
  var theme: PopFormFieldTheme = TextFieldTheme()
  var apiKey: String = "password"
  var placeholder: String = "Password"
  var validationRule: [Rule]? = [PasswordRule()]
  var isSecureEntry: Bool = true
  var returnKey: UIReturnKeyType = UIReturnKeyType.done
}

