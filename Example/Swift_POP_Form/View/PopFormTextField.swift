//
//  FormTextField.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

final class PopFormTextField: UITextField {
  
  var dataSource: PopFormFieldDataSource? {
    didSet {
      backgroundColor = dataSource?.theme.backgroundColor
      placeholder = dataSource?.placeholder
      text = dataSource?.stockData
      returnKeyType = dataSource?.returnKey ?? UIReturnKeyType.default
    }
  }
}
