//
//  PopFormDataSource.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

protocol PopForm_ViewModelDelegate: class {
  func registerForValidation(validatable: UITextField, rules: [Rule])
}

final class PopForm_ViewModel: NSObject {
  
  var delegate: PopForm_ViewModelDelegate?
  
  var dataSource: PopFormDataSource
  
  init(dataSource: PopFormDataSource){
    self.dataSource = dataSource
    super.init()
  }
}

extension PopForm_ViewModel:  UITableViewDataSource  {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: PopFormTableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: PopFormTableViewCell.ReuseID,
                                             for: indexPath) as? PopFormTableViewCell ?? PopFormTableViewCell()
    
    let field = cell.setView(for: dataSource.fields[indexPath.row])
    
    if let rules = dataSource.fields[indexPath.row].validationRule {
      delegate?.registerForValidation(validatable: field, rules: rules)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.fields.count
  }
}
