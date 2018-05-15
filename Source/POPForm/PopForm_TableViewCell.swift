//
//  FormTextField.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

final class PopForm_TableViewCell: UITableViewCell {
  
  static var ReuseID: String = "FormTextFieldCell"
  
  override var reuseIdentifier: String? {
    return PopForm_TableViewCell.ReuseID
  }
  
  
  lazy var textField: PopForm_TextField = {
    let tf = PopForm_TextField()
    addSubview(tf)
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.topAnchor.constraint(equalTo: topAnchor).isActive = true
    tf.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    tf.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    tf.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    return tf
  }()

  
  
  func setView(for dataSource: PopForm_FieldDataSource) -> UITextField {
    textField.dataSource = dataSource
    return textField
  }
}
