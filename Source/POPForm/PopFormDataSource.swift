//
//  Form.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import Foundation

typealias PopFormFields = [PopFormFieldDataSource]

/// The primary data source for each form
/// Create an array of *PopForm_Fields* and a *PopForm_Theme* to init
protocol PopFormDataSource {
  var fields: PopFormFields { get }
  var theme: PopFormTheme { get }
}
