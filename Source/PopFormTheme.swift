//
//  PopForm_Theme.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

/// The general theme of a form
/// currently supports backgroundColor and formColor
public protocol PopFormTheme {

  /// the background color of the form
  var backgroundColor: UIColor { get }

  /// the foreground color of the form
  var formColor: UIColor { get }
}
