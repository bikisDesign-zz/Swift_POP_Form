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
  
  func registerDatePickerForAction(datePicker: UIDatePicker)
  
  func pickerViewValueDidChange(value: String)
}

final class PopForm_ViewModel: NSObject {
  
  var delegate: PopForm_ViewModelDelegate?
  
  var dataSource: PopFormDataSource
  
  lazy var credentials = Credentials()
  
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
    
    if let startDate = dataSource.fields[indexPath.row].datePickerWithStartDate { // has a Date Picker as an InputView
      let datePicker = UIDatePicker()
      datePicker.setDate(startDate, animated: false)
      datePicker.datePickerMode = .date
      delegate?.registerDatePickerForAction(datePicker: datePicker)
      cell.textField.inputView = datePicker
    }
    
    if let pickerViewDataSource = dataSource.fields[indexPath.row].pickerViewWithDataSource { // has a custom picker view as an inputview
      let pickerView = PopFormPickerView(data: pickerViewDataSource)
      pickerView.formPickerDelegate = self
      cell.textField.inputView = pickerView
    }
    
    if let rules = dataSource.fields[indexPath.row].validationRule { // is not optional
      delegate?.registerForValidation(validatable: field, rules: rules)
    }
    
    cell.textField.text = credentials[dataSource.fields[indexPath.row].apiKey]
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.fields.count
  }
}


extension PopForm_ViewModel: PopFormPickerViewDelegate {
  func formPicker(didSelectValue value:String) {
    delegate?.pickerViewValueDidChange(value: value)
  }
}
