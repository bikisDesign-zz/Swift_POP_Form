//
//  PopFormViewController.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import SwiftValidator


protocol PopFormViewControllerDelegate: class {
  /// the form didn't pass validation
  func formWasInvalid()

  /// the form passed validation
  func formWasValid(callback: Credentials)

  /// The Form's editing status changed use this to animate the viewController's height so that the form's scrollview can update it's offset.
  ///
  /// - Parameters:
  ///   - keyboardOriginDelta: The distance that the keyboard is covering from the bottom of the popViewController's bottom bounds
  ///   - animationOptions: The animation options of the keyboard
  ///   - duration: the duration in which the keyboard is animating
  func formChangedEditingStatus(keyboardOriginDelta: CGFloat, animationOptions: UIView.AnimationOptions, duration: Double)

  /// Extends UITextFieldDelegate
  ///
  /// - Parameters:
  ///   - field: the currently editing PopFormTextField
  func formTextFieldShouldChangeCharectersInRange(text: String, range: NSRange, replacment: String, field: PopFormTextField) -> Bool

  /// Extends UITextFieldDelegate
  ///
  /// - Parameter field: the currently editing PopFormTextField
  func textFieldShouldBeginEditing(_ field: PopFormTextField) -> Bool

  /// Extends UITextFieldDelegate
  ///
  /// - Parameter field: the currently editing PopFormTextField
  func textFieldShouldReturn(_ textField: PopFormTextField) -> Bool
}

/// Can be either embeded in another VC or presented on its own.
/// By setting up the whole datasource elsewhere you can pass in an instance of *PopForm_DataSource* to create an instance of this viewcontroller
public class PopFormViewController: UIViewController {

  weak var delegate: PopFormViewControllerDelegate?

  /// If you'd like the form's return key to have different functionality
  /// set this to false and then use the textFieldShouldReturn(_ textField) callback
  var shouldValidateOnLastFieldReturnKeyTap = true

  /// disables the ability for the form to scroll
  var isScrollEnabled = true {
    didSet {
      tableView.isScrollEnabled = isScrollEnabled
    }
  }

  private var viewModel: PopForm_ViewModel

  private lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.delegate = self
    tv.dataSource = viewModel
    tv.backgroundColor = viewModel.dataSource.theme.backgroundColor
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.contentInset = UIEdgeInsets.init(top: 50, left: 0, bottom: 0, right: 0)
    tv.scrollIndicatorInsets = tv.contentInset
    tv.separatorStyle = .none
    tv.register(PopFormTableViewCell.self, forCellReuseIdentifier: PopFormTableViewCell.ReuseID)
    return tv
  }()

  private var validator = Validator()

  private lazy var currentIndexPath: IndexPath = IndexPath(row: 0, section: 0)

  init(dataSource: PopFormDataSource, credentials: Credentials? = nil){
    viewModel = PopForm_ViewModel(dataSource: dataSource)
    super.init(nibName: nil, bundle: nil)
    viewModel.textFieldDelegate = self
    viewModel.textViewDelegate = self
    viewModel.delegate = self
    if let credentials = credentials {
      viewModel.credentials = credentials
    }
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder: not supported")
  }

  /// To change the form's dataSource entirely set this
  /// will reload all fields
  /// - Parameter ds: the formDatasource to be updated
  public func update(ds: PopFormDataSource){
    viewModel.dataSource = ds
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }


  /// To update the credentials one or more field's update this. 
  ///
  /// - Parameter credentials: the credentials to be merged
  public func update(credentials: Credentials){
    viewModel.credentials.data.merge(credentials.data, uniquingKeysWith: { (_, new) -> Any in
      return new
    })
  }

  /// Gets all created credentials from the form
  public func getCredentials() -> Credentials {
    return viewModel.credentials
  }

  /// To force a reload of all fields
  public func reloadData(){
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }


  /// Determines if no credentials have been created in the form
  public func isCredentialsEmpty() -> Bool {
    return viewModel.credentials.data.isEmpty
  }


  override public func loadView() {
    view = UIView()
    view.backgroundColor = UIColor.clear
    view.translatesAutoresizingMaskIntoConstraints = false
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowOrHide(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowOrHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    addSubviews()
    configureViewLayout()
  }


  override public func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
  }


  private func addSubviews(){
    view.addSubview(tableView)
  }

  private func configureViewLayout(){
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }

  @objc private func keyboardWillShowOrHide(_ notification: NSNotification) {
    let userInfo = notification.userInfo!
    let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
    let rawAnimationCurveValue = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber).uintValue

    let animationCurve = UIView.AnimationOptions(rawValue: rawAnimationCurveValue)
    // Convert the keyboard frame from screen to view coordinates.
    let keyboardScreenBeginFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

    let keyboardViewBeginFrame = view.convert(keyboardScreenBeginFrame, from: view.window)
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

    // Determine how far the keyboard has moved up or down.
    let originDelta = keyboardViewEndFrame.origin.y - keyboardViewBeginFrame.origin.y
    let animationOptions: UIView.AnimationOptions = [animationCurve, .beginFromCurrentState]

    delegate?.formChangedEditingStatus(keyboardOriginDelta: originDelta, animationOptions: animationOptions, duration: animationDuration)
  }
  
  /// Force validation of the form
  public func validateForm(){
    validator.validate(self)
  }

  /// Sses the theme textViewHeight and textFieldHeight
  ///
  /// - Returns: Full height of the form
  public func formHeight() -> CGFloat {
    return CGFloat(viewModel.dataSource.fields.reduce(CGFloat(0), {
      if $1.isTextView {
        return $0 + $1.theme.textViewHeight
      }
      return $0 + $1.theme.textFieldHeight }))
  }

  private func getIndexPath(for field: ValidatableField) -> IndexPath? {
    let childField = field as? UIView
    guard let cell = childField?.superview?.superview as? PopFormTableViewCell else {
      fatalError() }

    guard let currentIndex = tableView.indexPath(for: cell) else {
      return nil }

    return currentIndex
  }

  private func refreshErrorUI(){
    for index in 0..<viewModel.dataSource.fields.count { // refresh the view
      let cell = (tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? PopFormTableViewCell)
      cell?.erroredText = nil
      cell?.animateStateChange()
    }
  }

  private func setCredentials(credential: Any){
    viewModel.credentials.data[viewModel.dataSource.fields[currentIndexPath.row].apiKey] = credential
  }

  @objc private func valueChangedFor(_ datePicker: UIDatePicker) {
    let cell = tableView.cellForRow(at: currentIndexPath) as! PopFormTableViewCell
    
    cell.textField.text = cell.fieldDataSource.datePickerWithDataSource?.formatForDisplayedDate(datePicker.date)
    setCredentials(credential: datePicker.date)
  }

  private func check(lhsKey: String, rhsKey: String, isComparisonResult: ComparisonResult, or secondComparisonResult: ComparisonResult? = nil) -> Bool {
    guard let lhsIndex = viewModel.dataSource.fields.firstIndex(where: { $0.apiKey == lhsKey }) else { return false }
    guard let rhsIndex = viewModel.dataSource.fields.firstIndex(where: { $0.apiKey == rhsKey }) else { return false }
    guard let lhsDate = viewModel.credentials.data[lhsKey] as? Date else { return false }
    guard let rhsDate = viewModel.credentials.data[rhsKey] as? Date else { return false }
    if lhsDate.compare(rhsDate) != isComparisonResult { // if it isn't orderded asc
      if let secondComapare = secondComparisonResult  { // and if there is a second to compare
        if lhsDate.compare(rhsDate) == secondComapare { // if it matches the second
          return true
        }
      }
      let lhsCell = tableView.cellForRow(at: IndexPath(row: lhsIndex, section: 0)) as! PopFormTableViewCell
      let rhsCell = tableView.cellForRow(at: IndexPath(row: rhsIndex, section: 0)) as! PopFormTableViewCell
      lhsCell.erroredText = "start date is greater than end date"
      lhsCell.animateStateChange()
      rhsCell.erroredText = "end date is less than start date"
      rhsCell.animateStateChange()
      return false
    }
    return true
  }


  /// Force selection of a field
  /// Will remove the erroredText if one exists
  public func setSelectionFor(field: ValidatableField){
    guard let indexPath = getIndexPath(for: field) else { return }
    currentIndexPath = indexPath
    let cell = tableView.cellForRow(at: currentIndexPath) as! PopFormTableViewCell
    cell.isCurrentlyFocused = true
    cell.erroredText = nil
    cell.animateStateChange()
    if let datepicker = cell.textField.inputView as? UIDatePicker {
      cell.textField.text = cell.fieldDataSource.datePickerWithDataSource?.formatForDisplayedDate(datepicker.date)
      setCredentials(credential: datepicker.date)
    }
  }


  /// Force deselection of a field
  public func setDeselectionFor(field: ValidatableField){
    guard let indexPathForUnselectedCell = getIndexPath(for: field) else { return }
    let cell = tableView.cellForRow(at: indexPathForUnselectedCell) as! PopFormTableViewCell
    cell.isCurrentlyFocused = false
    cell.animateStateChange()
  }
}



//MARK: TableViewDelegate
extension PopFormViewController: UITableViewDelegate {

  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let fieldDataSource = viewModel.dataSource.fields[indexPath.row]
    if fieldDataSource.isTextView {
      return fieldDataSource.theme.textViewHeight
    }
    return fieldDataSource.theme.textFieldHeight
  }
}

extension PopFormViewController: PopForm_ViewModelDelegate {
  public func registerForValidation(validatable: ValidatableField, rules: [Rule]) {
    validator.registerField(validatable, rules: rules)
  }

  public func registerDatePickerForAction(datePicker: UIDatePicker) {
    datePicker.addTarget(self, action: #selector(valueChangedFor(_:)), for: .valueChanged)
  }

  public func pickerViewValueDidChange(value: String) {
    let cell = tableView.cellForRow(at: currentIndexPath) as! PopFormTableViewCell
    cell.textField.text = value
    setCredentials(credential: value)
  }
}


//MARK: TextView Delegate
extension PopFormViewController: UITextViewDelegate {
  public func textViewDidBeginEditing(_ textView: UITextView) {
    setSelectionFor(field: textView)
    let fieldDataSource = viewModel.dataSource.fields[currentIndexPath.row]
    if textView.textColor == fieldDataSource.theme.placeholderTextColor {
      textView.text = nil
      textView.textColor = fieldDataSource.theme.textColor
    }
  }

  public func textViewDidEndEditing(_ textView: UITextView) {
    setDeselectionFor(field: textView)
    if textView.text.isEmpty {
      guard let index = getIndexPath(for: textView) else { return }
      textView.text = viewModel.dataSource.fields[index.row].placeholder
      let fieldDatasource = viewModel.dataSource.fields[currentIndexPath.row]
      textView.textColor = fieldDatasource.theme.placeholderTextColor
    }
  }

  public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let previous = textView.text ?? ""
    let fullText = (previous as NSString).replacingCharacters(in: range, with: text)
    setCredentials(credential: fullText)
    return true
  }
}


//MARK: TextField Delegate
extension PopFormViewController: UITextFieldDelegate {

  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let popField = textField as? PopFormTextField else { return false }
    guard delegate?.textFieldShouldReturn(popField) == true else { return false }
    guard let activeIndex = getIndexPath(for: textField) else { return false }
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

  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let text = textField.text ?? ""
    let fullText = (text as NSString).replacingCharacters(in: range, with: string)
    setCredentials(credential: fullText)
    return delegate?.formTextFieldShouldChangeCharectersInRange(text: text,
                                                                range: range,
                                                                replacment: string,
                                                                field: textField as! PopFormTextField) ?? true
  }

  public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    if let shouldBegin = delegate?.textFieldShouldBeginEditing(textField as! PopFormTextField) {
      return shouldBegin
    }
    return true
  }

  public func textFieldDidBeginEditing(_ textField: UITextField) {
    setSelectionFor(field: textField)
    if textField.isSecureTextEntry {
      textField.text = ""
    }
  }

  public func textFieldDidEndEditing(_ textField: UITextField) {
    setDeselectionFor(field: textField)
  }
}

//MARK: Validation Delegate
extension PopFormViewController: ValidationDelegate {
  public func validationSuccessful() {
    refreshErrorUI()
    delegate?.formWasValid(callback: viewModel.credentials)
  }

  public func validationFailed(_ errors: [(Validatable, ValidationError)]) {
    refreshErrorUI()
    errors.forEach { (arg) in // show errors
      let (field, _) = arg
      self.invalidate(field: field, erroredText: arg.1.errorMessage)
    }
    delegate?.formWasInvalid()
  }

  private func invalidate(field: Validatable, erroredText: String){
    if let field = field as? PopFormTextField {
      let cell = field.superview?.superview as! PopFormTableViewCell /// cell's contentView
      cell.erroredText = erroredText
      cell.animateStateChange()
    }

  }

  func updateAndValidateField(matching apiKey: String, with text: String){
    guard let index = viewModel.dataSource.fields.firstIndex(where: { $0.apiKey == apiKey }) else { return }
    guard let cell = tableView.cellForRow(at: IndexPath(row: Int(index), section: 0)) as? PopFormTableViewCell else { return }
    cell.textField.text = text
    validator.validateField(cell.textField) { (error) in
      if let error = error {
        invalidate(field: cell.textField, erroredText: error.errorMessage)
      } else {
        cell.erroredText = nil
        cell.animateStateChange()
      }
    }
  }
}
