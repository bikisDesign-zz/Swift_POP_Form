//
//  FormTextField.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

final class FormTextField: UITextField {
  
  var dataSource: PopForm_FieldDataSource? {
    didSet {
      backgroundColor = dataSource.theme.backgroundColor
      placeholder = dataSource.placeholder
      textField.text = dataSource.stockData
    }
  }
}
