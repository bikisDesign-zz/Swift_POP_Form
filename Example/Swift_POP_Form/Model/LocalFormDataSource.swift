//
//  LocalFormDataSource.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import SwiftValidator

struct LocalFormDataSource: PopFormDataSource {
  var fields: PopFormFields = [FirstName_Field(),
                               LastName_Field(),
                               Zip_Field(),
                               PhoneNumber_Field(),
                               Occupation_Field(),
                               Notes_Field(),
                               Birthday_Field(),
                               Password_Field()]
  
  var theme: PopFormTheme = FormTheme()
}


private struct FormTheme: PopFormTheme {
  var backgroundColor: UIColor = .white
  var formColor: UIColor = .white
}



private struct TextFieldTheme: PopFormFieldTheme {

  var focusedColor: UIColor = UIColor.lightGray

  var textfieldFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .light)
  
  var borderOpacity: Float = 0.85
  
  var textAlignment: NSTextAlignment = .center
  
  var borderIsUnderline: Bool = false
  
  var errorColor: UIColor = .red
  
  var backgroundColor: UIColor = UIColor.white
  
  var textColor: UIColor = UIColor.black
  
  var placeholderTextColor: UIColor = UIColor.lightGray
  
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
    return "\(day).\(month).\(year)"
  }
}


//MARK: Fields

private struct FirstName_Field: PopFormFieldDataSource {
  var prefilledText: String?

  var theme: PopFormFieldTheme = TextFieldTheme()

  var placeholder: String = "First Name"

  var apiKey: String = "firstName"

  var validationRule: [Rule]? = [RequiredRule()]

  var returnKey: UIReturnKeyType? = .next

  var autoCapitilization: UITextAutocapitalizationType = .words
}

private struct LastName_Field: PopFormFieldDataSource {
  var prefilledText: String?

  var theme: PopFormFieldTheme = TextFieldTheme()

  var placeholder: String = "Last Name"

  var apiKey: String = "lastName"

  var validationRule: [Rule]?

  var returnKey: UIReturnKeyType? = .next

  var autoCapitilization: UITextAutocapitalizationType = .words
}

private struct Occupation_Field: PopFormFieldDataSource {
  var prefilledText: String?

  var theme: PopFormFieldTheme = TextFieldTheme()

  var placeholder: String = "Occupation"

  var apiKey: String = "job"

  var validationRule: [Rule]? = [RequiredRule()]

  var returnKey: UIReturnKeyType? = .next

  var autoCapitilization: UITextAutocapitalizationType = .none

  var pickerViewWithDataSource: PopFormPickerViewDataSource? = Occupation_PickerViewDataSource()
}

private struct Occupation_PickerViewDataSource: PopFormPickerViewDataSource {
  var content: [String] = ["Student", "iOS Developer", "Professional Wrestler"]
}

private struct PhoneNumber_Field: PopFormFieldDataSource {
  var prefilledText: String?

  var theme: PopFormFieldTheme = TextFieldTheme()

  var placeholder: String = "Phone Number"

  var apiKey: String = "phone_number"

  var validationRule: [Rule]? = [PhoneNumberRule(message: "Invalid US Phone Number")]

  var returnKey: UIReturnKeyType? = .next

  var keyboardType: UIKeyboardType = .phonePad

  var autoCapitilization: UITextAutocapitalizationType = .none
}

private struct Zip_Field: PopFormFieldDataSource {
  var prefilledText: String?

  var theme: PopFormFieldTheme = TextFieldTheme()

  var placeholder: String = "ZIP"

  var apiKey: String = "zip"

  var validationRule: [Rule]? = [ZipCodeRule(message: "Invalid US ZIP Code")]

  var returnKey: UIReturnKeyType? = .next

  var keyboardType: UIKeyboardType = .decimalPad

  var autoCapitilization: UITextAutocapitalizationType = .none
}


private struct Password_Field: PopFormFieldDataSource {
  var prefilledText: String?

  var theme: PopFormFieldTheme = TextFieldTheme()

  var placeholder: String = "Password"

  var apiKey: String = "password"

  var validationRule: [Rule]? = [PasswordRule(regex: "^.{8,}$", message: "Must be 8 characeters long")]

  var returnKey: UIReturnKeyType? = .go

  var autoCapitilization: UITextAutocapitalizationType = .words

  var isSecureEntry: Bool = true
}


private struct Birthday_Field: PopFormFieldDataSource {
  var prefilledText: String?

  var theme: PopFormFieldTheme = TextFieldTheme()

  var placeholder: String = "Birthday"

  var apiKey: String = "birthday"

  var validationRule: [Rule]? = [MinDateRule(dateFormat: "dd.MM.yy")]

  var returnKey: UIReturnKeyType?

  var autoCapitilization: UITextAutocapitalizationType = .none

  var datePickerWithDataSource: PopFormDatePickerDataSource? = BirthdayDatePickerDataSource()
}

private struct Notes_Field: PopFormFieldDataSource {
  var prefilledText: String?

  var theme: PopFormFieldTheme = TextFieldTheme()

  var placeholder: String = "Notes"

  var apiKey: String = "notes"

  var validationRule: [Rule]?

  var returnKey: UIReturnKeyType?

  var autoCapitilization: UITextAutocapitalizationType = .none

  var isTextView: Bool = true
}
