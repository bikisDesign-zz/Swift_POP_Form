//
//  PopFormViewController.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import RP_iosBootstrap

final class PopForm_ViewController: UIViewController {
  
  private var viewModel: PopForm_ViewModel
 
  private lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.delegate = self
    tv.dataSource = viewModel
    tv.backgroundColor = viewModel.dataSource.theme.backgroundColor
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.ReuseID)
    view.addSubview(tv)
    return tv
  }()
  
  private var validator = Validator()
  
  
  init(dataSource: PopForm_DataSource){
    self.viewModel = PopForm_ViewModel(dataSource: dataSource)
    super.init(nibName: nil, bundle: nil)
    self.viewModel.delegate = self
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder: not supported")
  }
  
  override func loadView() {
    view = UIView()
    view.backgroundColor = UIColor.white // add to theme
    view.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
}


extension PopForm_ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return viewModel.dataSource.fields[indexPath.row].theme.height
  }
}

extension PopForm_ViewController: PopForm_ViewModelDelegate {
  func registerForValidation(validatable: UITextField, rules: [Rule]) {
    validator.registerField(validatable, rules: rules)
    validatable.delegate = self
  }
}

extension PopForm_ViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let cell = textField.superview as? FormTableViewCell else {
      fatalError() }
    
    guard let currentIndex = tableView.indexPath(for: cell) else {
      fatalError("cell does not exist") }
    
    let nextIndex = IndexPath(row: currentIndex.row + 1, section: currentIndex.section)
    let isLastField = viewModel.dataSource.fields.count == nextIndex.row
    
    if isLastField {
      cell.textField.resignFirstResponder()
      return true
    }
    
    guard let nextCell = tableView.cellForRow(at: nextIndex) as? FormTableViewCell else {
      fatalError() }
    
    nextCell.textField.becomeFirstResponder()
    return true
  }
}
