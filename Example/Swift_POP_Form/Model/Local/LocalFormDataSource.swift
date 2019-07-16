//
//  LocalFormDataSource.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit


struct LocalFormDataSource: PopFormDataSource {
  var fields: PopFormFields = [FirstName_Field(),
                               LastName_Field(),
                               Password_Field()]
  
  var theme: PopFormTheme = FormTheme()
}


private struct FormTheme: PopFormTheme {
  var backgroundColor: UIColor = .white
  var formColor: UIColor = .white
}



private struct TextFieldTheme: PopFormFieldTheme {

  var focusedColor: UIColor = UIColor.lightGray

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

  var textFieldHeight: CGFloat = 60

  var textViewHeight: CGFloat = 120

  var cursorColor: UIColor = UIColor.blue
}


private struct BirthdayDatePickerDataSource: PopFormDatePickerDataSource {
  var startDate: Date? = nil

  var restrictedDateRange: (Date, Date)? = nil

  var shouldPrefillStartDate: Bool = false

  var formatForDisplayedDate: (Date) -> String = {
    let df = DateFormatter()
    df.dateFormat = "MM"
    let month = df.string(from: $0)
    df.dateFormat = "dd"
    let day = df.string(from: $0)
    df.dateFormat = "yy"
    let year = df.string(from: $0)
    return "\(day).\(month)\(year)"
  }
}


private struct FirstName_Field: PopFormFieldDataSource {
  var prefilledText: String?

  var theme: PopFormFieldTheme = TextFieldTheme()

  var placeholder: String = "First Name"

  var apiKey: String = "firstName"

  var validationRule: [Rule]?

  var returnKey: UIReturnKeyType?

  var autoCapitilization: UITextAutocapitalizationType = .words
}


private struct LastName_Field: PopFormFieldDataSource {
  var prefilledText: String?

  var theme: PopFormFieldTheme = TextFieldTheme()

  var placeholder: String = "Last Name"

  var apiKey: String = "lastName"

  var validationRule: [Rule]?

  var returnKey: UIReturnKeyType?

  var autoCapitilization: UITextAutocapitalizationType = .words
}


private struct Password_Field: PopFormFieldDataSource {
  var prefilledText: String?

  var theme: PopFormFieldTheme = TextFieldTheme()

  var placeholder: String = "Password"

  var apiKey: String = "password"

  var validationRule: [Rule]?

  var returnKey: UIReturnKeyType?

  var autoCapitilization: UITextAutocapitalizationType = .words
}
