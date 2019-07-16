//
//  FormTextField.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

final class PopFormTableViewCell: UITableViewCell {

  private enum BorderAnimState {
    case focused, errored, normal
  }

  static var ReuseID: String = "FormTextFieldCell"

  override var reuseIdentifier: String? {
    return PopFormTableViewCell.ReuseID
  }

  var fieldDataSource: PopFormFieldDataSource!

  var erroredText: String?

  var isCurrentlyFocused = false

  lazy var textField: PopFormTextField = {
    let tf = PopFormTextField()
    addSubview(tf)
    return tf
  }()

  lazy var textView: PopFormTextView = {
    let tv = PopFormTextView()
    addSubview(tv)
    return tv
  }()

  private lazy var errorTitleLabel: UILabel = {
    let l = UILabel()
    l.textColor = self.fieldDataSource.theme.errorColor
    l.font = self.fieldDataSource.theme.textfieldFont
    l.alpha = 1
    addSubview(l)
    return l
  }()

  private lazy var borderLine: CAShapeLayer = {
    let l = CAShapeLayer()
    let linePath = UIBezierPath()
    linePath.move(to: CGPoint(x: 15, y: frame.height - 30))
    linePath.addLine(to: CGPoint(x: frame.width - 30, y: frame.height - 30)) // set it 5 below the textfield
    l.path = linePath.cgPath
    layer.addSublayer(l)
    return l
  }()

  private var textViewConstraints: [NSLayoutConstraint]?
  private var textFieldConstraints: [NSLayoutConstraint]?
  private var errorLabelTopConstraint: NSLayoutConstraint?

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureViewLayout()
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }


  func animateStateChange(){
    if let text = erroredText {
      UIView.animate(withDuration: 0.5) { // animate changes
        self.errorTitleLabel.text = text
        self.errorTitleLabel.alpha = 1.0
      }
      animateBorderForState(animState: .errored)
      return
    }

    if isCurrentlyFocused {
      animateBorderForState(animState: .focused)
      return
    }
    animateBorderForState(animState: .normal)
    UIView.animate(withDuration: 0.5) {
      self.errorTitleLabel.text = nil
      self.errorTitleLabel.alpha = 0
    }
  }

  private func animateBorderForState(animState: BorderAnimState){
    let colorAnim = CABasicAnimation(keyPath: "strokeColor")
    colorAnim.duration = 0.5
    colorAnim.repeatCount = 1
    colorAnim.fromValue = borderLine.borderColor
    var toValue: CGColor?
    switch animState {
    case .normal:
      toValue = self.fieldDataSource.theme.borderColor.cgColor
    case .errored:
      toValue = self.fieldDataSource.theme.errorColor.cgColor
    case .focused:
      toValue = self.fieldDataSource.theme.focusedColor.cgColor
    }
    borderLine.strokeColor = toValue
    borderLine.lineWidth = 1
    colorAnim.toValue = toValue

    borderLine.add(colorAnim, forKey: "strokeColor")
  }

  private func configureViewLayout(){
    NSLayoutConstraint
      .activate([errorTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                 errorTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
                 errorTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
  }

  func setField(for dataSource: PopFormFieldDataSource, prefillText: String) -> ValidatableField {
    setGenericView(for: dataSource)
    if dataSource.isTextView {
      setTextView(with: prefillText)
      return textView
    }
    setTextField(with: prefillText)
    return textField
  }

  private func setGenericView(for dataSource: PopFormFieldDataSource){
    self.fieldDataSource = dataSource
    backgroundColor = UIColor.clear
    selectionStyle = dataSource.selectionStyle
    borderLine.lineWidth = 1
    borderLine.opacity = dataSource.theme.borderOpacity
    borderLine.strokeColor = dataSource.theme.borderColor.cgColor
  }

  func setTextView(with prefilledText: String){
    textView.dataSource = fieldDataSource
    if prefilledText != "" {
      textView.text = prefilledText
    } else {
      textView.text = fieldDataSource.placeholder
      textView.textColor = fieldDataSource.theme.placeholderTextColor
    }
    addSubview(textView)
    textField.removeFromSuperview()

    textFieldConstraints?.forEach({ $0.isActive = false })

    textViewConstraints = [textView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                           textView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
                           textView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
                           textView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 35)]

    NSLayoutConstraint.activate(textViewConstraints!)
    setErrorLabelConstraint(forTextField: false)
  }

  private func setTextField(with prefilledText: String){
    textField.dataSource = fieldDataSource
    if prefilledText !=  "" {
      textField.text = prefilledText
    }
    addSubview(textField)
    textView.removeFromSuperview()

    if textViewConstraints != nil {
      NSLayoutConstraint.deactivate(textViewConstraints!)
    }

    textFieldConstraints = [textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
                            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
                            textField.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 35)]

    NSLayoutConstraint.activate(textFieldConstraints!)

    setErrorLabelConstraint(forTextField: true)

    // set placeholder text theme
    if let placeholder = textField.placeholder {
      textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                           attributes: [NSAttributedString.Key.foregroundColor:  fieldDataSource.theme.placeholderTextColor])
    }
  }


  private func setErrorLabelConstraint(forTextField: Bool){
    if errorLabelTopConstraint != nil {
      NSLayoutConstraint.deactivate([errorLabelTopConstraint!])
    }
    if forTextField {
      errorLabelTopConstraint = errorTitleLabel.topAnchor.constraint(equalTo: textField.bottomAnchor)
    } else {
      errorLabelTopConstraint = errorTitleLabel.topAnchor.constraint(equalTo: textView.bottomAnchor)
    }
    NSLayoutConstraint.activate([errorLabelTopConstraint!])
  }
}
