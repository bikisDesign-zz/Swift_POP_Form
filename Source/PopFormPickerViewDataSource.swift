//
//  PopFormPickerViewDataSource.swift
//  Swift_POP_Form
//
//  Created by Dev Bikis on 7/16/19.
//  Copyright © 2019 Aaron bikis. All rights reserved.
//

import Foundation

/// The Datasource passed to a field containing a pickerview
protocol PopFormPickerViewDataSource {
  /// the content to fill the picker view (**currently only supports a single list**)
  var content: [String] { get set }
}
