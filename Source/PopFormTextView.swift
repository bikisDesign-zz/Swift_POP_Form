//
//  PopFormTextView.swift
//  Swift_POP_Form
//
//  Created by Dev Bikis on 7/16/19.
//  Copyright © 2019 Aaron bikis. All rights reserved.
//

import UIKit

/// A UITextView PopField
public class PopFormTextView: UITextView {

  var dataSource: PopFormFieldDataSource! {
    didSet {
      backgroundColor = dataSource.theme.backgroundColor
      text = dataSource.placeholder
      textColor = dataSource.theme.textColor
      text = dataSource.stockData
      font = dataSource.theme.textfieldFont
      tintColor = dataSource.theme.cursorColor
      returnKeyType = dataSource.returnKey ?? .default
      textAlignment = dataSource.theme.textAlignment
      autocapitalizationType = dataSource.autoCapitilization
      autocorrectionType = dataSource.hasAutoCorrection
      isSecureTextEntry = dataSource.isSecureEntry
      keyboardType = dataSource.keyboardType
    }
  }

  init(){
    super.init(frame: .zero, textContainer: nil)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}
