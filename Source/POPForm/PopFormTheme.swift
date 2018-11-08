//
//  PopForm_Theme.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

/// The general theme of every form
/// currently supports backgroundColor and formColor
protocol PopFormTheme {
  var backgroundColor: UIColor { get }
  var formColor: UIColor { get }
  var preventScrolling: Bool { get }
}

extension PopFormTheme {
  var preventScrolling: Bool { return false }
}
