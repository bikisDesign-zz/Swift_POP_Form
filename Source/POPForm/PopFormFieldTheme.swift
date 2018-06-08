//
//  PopFormTheme.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

protocol PopFormFieldTheme {
  var backgroundColor: UIColor { get }
  var textColor: UIColor { get }
  var placeholderTextColor: UIColor { get }
  var borderColor: UIColor { get }
  var borderWidth: CGFloat { get }
  var height: CGFloat { get }
}
