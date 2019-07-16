//
//  PopFormDataSource.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

protocol PopForm_ViewModelDelegate: class {
  func registerForValidation(validatable: ValidatableField, rules: [Rule])

  func registerDatePickerForAction(datePicker: UIDatePicker)

  func pickerViewValueDidChange(value: String)
}

final class PopForm_ViewModel: NSObject {

  var delegate: PopForm_ViewModelDelegate?

  var dataSource: PopFormDataSource

  weak var textFieldDelegate: UITextFieldDelegate?
  weak var textViewDelegate: UITextViewDelegate?

  var credentials = Credentials()

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

    let fieldDataSource = dataSource.fields[indexPath.row]

    let validatableField = cell.setField(for: fieldDataSource,
                                         prefillText: credentials.data[fieldDataSource.apiKey] as? String
                                          ?? fieldDataSource.prefilledText
                                          ?? "")
    if let textField = validatableField as? UITextField {
      textField.delegate = textFieldDelegate
    }
    if let textView = validatableField as? UITextView {
      textView.delegate = textViewDelegate
    }

    if let rules = fieldDataSource.validationRule { // is not optional
      delegate?.registerForValidation(validatable: validatableField, rules: rules)
    }

    if let datePickerDS = fieldDataSource.datePickerWithDataSource { // has a Date Picker as an InputView
      let datePicker = UIDatePicker()

      if let selectedDate = credentials.data[fieldDataSource.apiKey] as? Date { // unwinding or reloading with a selected date
        datePicker.setDate(selectedDate, animated: false)
        cell.textField.text = datePickerDS.formatForDisplayedDate(selectedDate)
      }

      if let prefillDate = datePickerDS.startDate { // prefilling the date from the startDate
        datePicker.setDate(prefillDate, animated: false)
        if datePickerDS.shouldPrefillStartDate {
          cell.textField.text = datePickerDS.formatForDisplayedDate(prefillDate)
        }
      }

      datePicker.minimumDate = datePickerDS.restrictedDateRange?.0
      datePicker.maximumDate = datePickerDS.restrictedDateRange?.1
      datePicker.datePickerMode = .date
      delegate?.registerDatePickerForAction(datePicker: datePicker)
      cell.textField.inputView = datePicker
    }

    if let pickerViewDataSource = fieldDataSource.pickerViewWithDataSource { // has a custom picker view as an inputview
      let pickerView = PopFormPickerView(data: pickerViewDataSource)
      pickerView.formPickerDelegate = self
      cell.textField.inputView = pickerView
    }
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
