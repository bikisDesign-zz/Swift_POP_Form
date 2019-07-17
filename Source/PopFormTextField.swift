//
//  FormTextField.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

public class PopFormTextField: UITextField {
  

  var dataSource: PopFormFieldDataSource! {
    didSet {
      backgroundColor = dataSource.theme.backgroundColor
      placeholder = dataSource.placeholder
      textColor = dataSource.theme.textColor
      text = dataSource.stockData
      font = dataSource.theme.textfieldFont
      tintColor = dataSource.theme.cursorColor
      returnKeyType = dataSource.returnKey ?? .default
      textAlignment = dataSource.theme.textAlignment
      autocapitalizationType = dataSource.autoCapitilization
      autocorrectionType = dataSource.hasAutoCorrection
      isSecureTextEntry = dataSource.isSecureEntry
      keyboardType = dataSource.keyboardType
    }
  }
}
