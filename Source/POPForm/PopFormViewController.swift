//
//  PopFormViewController.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit


protocol PopFormViewControllerDelegate: class {
  func formWasInvalid()
  func formWasValid(callback: Credentials)
  func formChangedEditingStatus(isEditing: Bool, keyboardHeight: CGFloat)
  func formTextFieldShouldChangeCharectersInRange(text: String, range: NSRange, replacment: String, field: PopFormTextField) -> Bool
}

/// Can be either embeded in another VC or presented on its own.
/// By setting up the whole datasource elsewhere you can pass in an instance of *PopForm_DataSource* to create an instance of this viewcontroller
final class PopFormViewController: UIViewController {
  
  weak var delegate: PopFormViewControllerDelegate?
  
  var shouldValidateOnLastFieldReturnKeyTap = true
  
  private var viewModel: PopForm_ViewModel
  
  private lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.delegate = self
    tv.dataSource = viewModel
    tv.backgroundColor = viewModel.dataSource.theme.backgroundColor
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.separatorStyle = .none
    tv.register(PopFormTableViewCell.self, forCellReuseIdentifier: PopFormTableViewCell.ReuseID)
    tv.isScrollEnabled = !viewModel.dataSource.theme.preventScrolling
    view.addSubview(tv)
    return tv
  }()
  
  private var validator = Validator()
  
  private lazy var currentIndexPath: IndexPath = IndexPath(row: 0, section: 0)
  
  init(dataSource: PopFormDataSource){
    self.viewModel = PopForm_ViewModel(dataSource: dataSource)
    super.init(nibName: nil, bundle: nil)
    self.viewModel.delegate = self
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder: not supported")
  }
  
  
  override func loadView() {
    view = UIView()
    view.backgroundColor = UIColor.clear
    view.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    
  }
  
  @objc private func keyboardWillShow(_ notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      let keyboardHeight = keyboardSize.height
      delegate?.formChangedEditingStatus(isEditing: true, keyboardHeight: keyboardHeight)
    }
  }
  
  @objc private func keyboardWillHide(_ notification: NSNotification) {
    delegate?.formChangedEditingStatus(isEditing: false, keyboardHeight: 0)
  }
  
  
  func validateForm(){
    validator.validate(self)
  }
  
  func formHeight() -> CGFloat {
    return CGFloat(viewModel.dataSource.fields.reduce(0, { $0 + $1.theme.height }))
  }
  
  private func getIndexPath(for textField: UITextField) -> IndexPath {
    guard let cell = textField.superview as? PopFormTableViewCell else {
      fatalError() }
    
    guard let currentIndex = tableView.indexPath(for: cell) else {
      fatalError("cell does not exist") }
    
    return currentIndex
  }
  
  private func refreshErrorUI(){
    for index in 0..<viewModel.dataSource.fields.count { // refresh the view
      (tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? PopFormTableViewCell)?.isErrored = false
    }
  }
  
  private func setCredentials(credential: String){
    viewModel.credentials[viewModel.dataSource.fields[currentIndexPath.row].apiKey] = credential
  }
  
  @objc private func valueChangedFor(_ datePicker: UIDatePicker) {
    let df = DateFormatter()
    df.dateFormat = "MM/dd/yy"
    let date = df.string(from: datePicker.date)
    let cell = tableView.cellForRow(at: currentIndexPath) as! PopFormTableViewCell
    cell.textField.text = date
    setCredentials(credential: date)
  }
}


//MARK: TableViewDelegate
extension PopFormViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return viewModel.dataSource.fields[indexPath.row].theme.height
  }
}

extension PopFormViewController: PopForm_ViewModelDelegate {
  func registerForValidation(validatable: UITextField, rules: [Rule]) {
    validator.registerField(validatable, rules: rules)
    validatable.delegate = self
  }
  
  func registerDatePickerForAction(datePicker: UIDatePicker) {
    datePicker.addTarget(self, action: #selector(valueChangedFor(_:)), for: .valueChanged)
  }
  
  func pickerViewValueDidChange(value: String) {
    let cell = tableView.cellForRow(at: currentIndexPath) as! PopFormTableViewCell
    cell.textField.text = value
    setCredentials(credential: value)
  }
}


//MARK: TextField Delegate
extension PopFormViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let activeIndex = getIndexPath(for: textField)
    let nextIndex = IndexPath(row: activeIndex.row + 1, section: activeIndex.section)
    let isLastField = viewModel.dataSource.fields.count == nextIndex.row
    
    if isLastField {
      textField.resignFirstResponder()
      if shouldValidateOnLastFieldReturnKeyTap {
        validator.validate(self)
      }
      return true
    }
    
    guard let nextCell = tableView.cellForRow(at: nextIndex) as? PopFormTableViewCell else { fatalError() }
    
    nextCell.textField.becomeFirstResponder()
    return true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let text = textField.text ?? ""
    let fullText = (text as NSString).replacingCharacters(in: range, with: string)
    setCredentials(credential: fullText)
    return delegate?.formTextFieldShouldChangeCharectersInRange(text: text,
                                                                range: range,
                                                                replacment: string,
                                                                field: textField as! PopFormTextField) ?? true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
    currentIndexPath = getIndexPath(for: textField)
    
    if textField.isSecureTextEntry {
      textField.text = ""
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    validator.validateField(textField) { (error) in
      if error != nil {
        invalidate(field: textField)
        return
      }
      refreshErrorUI()
    }
  }
}

//MARK: Validation Delegate
extension PopFormViewController: ValidationDelegate {
  func validationSuccessful() {
    refreshErrorUI()
    delegate?.formWasValid(callback: viewModel.credentials)
  }
  
  func validationFailed(_ errors: [(Validatable, ValidationError)]) {
    refreshErrorUI()
    errors.forEach { (arg) in // show errors
      let (field, _) = arg
      self.invalidate(field: field)
    }
    delegate?.formWasInvalid()
  }
  
  private func invalidate(field: Validatable){
    if let field = field as? PopFormTextField {
      (field.superview as? PopFormTableViewCell)?.isErrored = true
    }
  }
}
