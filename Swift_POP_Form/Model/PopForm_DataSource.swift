//
//  Form.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import Foundation

typealias PopForm_Fields = [PopForm_FieldDataSource]

protocol PopForm_DataSource {
  var fields: PopForm_Fields { get }
  var theme: PopForm_Theme { get }
}
