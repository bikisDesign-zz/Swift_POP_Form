//
//  PopFormDataSource.swift
//  Swift_POP_Form
//
//  Created by Dev Bikis on 7/16/19.
//  Copyright © 2019 Aaron bikis. All rights reserved.
//

import Foundation

typealias PopFormFields = [PopFormFieldDataSource]

/// The primary data source for each form
/// Create an array of *PopForm_Fields* and a *PopForm_Theme* to init
protocol PopFormDataSource {
  var fields: PopFormFields { get set }
  var theme: PopFormTheme { get }
}
