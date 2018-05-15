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
protocol PopForm_Theme {
  var backgroundColor: UIColor { get }
  var formColor: UIColor { get }
}
