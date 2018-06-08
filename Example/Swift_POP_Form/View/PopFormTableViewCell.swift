//
//  FormTextField.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

final class PopFormTableViewCell: UITableViewCell {
  
  static var ReuseID: String = "FormTextFieldCell"
  
  override var reuseIdentifier: String? {
    return PopFormTableViewCell.ReuseID
  }
  
  
  lazy var textField: PopFormTextField = {
    let tf = PopFormTextField()
    addSubview(tf)
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.topAnchor.constraint(equalTo: topAnchor).isActive = true
    tf.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    tf.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    tf.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    return tf
  }()

  
  
  func setView(for dataSource: PopFormFieldDataSource) -> UITextField {
    textField.dataSource = dataSource
    return textField
  }
}
