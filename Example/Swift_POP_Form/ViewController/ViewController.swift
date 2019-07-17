//
//  ViewController.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit


class FullPageFormViewController: UIViewController, PopFormViewControllerDelegate {

  private var formDataSource: PopFormDataSource

  private lazy var formVC: PopFormViewController = {
    let f = PopFormViewController(dataSource: formDataSource)
    f.view.translatesAutoresizingMaskIntoConstraints = false
    f.delegate = self
    return f
  }()

  private var formBottomConstraint: NSLayoutConstraint!

  init(formDataSource: PopFormDataSource){
    self.formDataSource = formDataSource
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  override func loadView() {
    super.loadView()
    addGestures()
    addSubviews()
    configureViewLayout()
    title = "Swift POP Form"
    let rightBarButton = UIBarButtonItem(title: "Validate", style: .plain, target: self, action: #selector(onValidationTap))
    navigationItem.setRightBarButton(rightBarButton, animated: false)
  }

  private func addGestures(){
    let tgr = UITapGestureRecognizer(target: self, action: #selector(onEndEditTap))
    view.addGestureRecognizer(tgr)
  }

  private func addSubviews() {
    addChild(formVC)
    view.addSubview(formVC.view)
    formVC.view.frame = view.frame
    formVC.didMove(toParent: self)
  }

  private func configureViewLayout() {
    NSLayoutConstraint.activate([formVC.view.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                                 formVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                 formVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)])

    formBottomConstraint = formVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    formBottomConstraint.isActive = true
  }

  @objc private func onEndEditTap(){
    view.endEditing(true)
  }

  @objc private func onValidationTap(){
    onEndEditTap()
    formVC.validateForm()
  }

  // MARK: PopFormViewControllerDelegate
  func formTextFieldShouldChangeCharectersInRange(text: String, range: NSRange, replacment: String, field: PopFormTextField) -> Bool {
    return true
  }

  func textFieldShouldBeginEditing(_ field: PopFormTextField) -> Bool {
    return true
  }

  func textFieldShouldReturn(_ textField: PopFormTextField) -> Bool {
    return true
  }

  func formWasInvalid() {}

  func formWasValid(callback: Credentials) {
    print(callback)
    let ac = UIAlertController(title: "All Fields Done Gone Valid", message: "POP", preferredStyle: .alert)
    let action = UIAlertAction(title: "Rad!", style: .destructive, handler: nil)
    ac.addAction(action)
    present(ac, animated: true, completion: nil)
  }

  func formChangedEditingStatus(keyboardOriginDelta: CGFloat, animationOptions: UIView.AnimationOptions, duration: Double) {
    if keyboardOriginDelta > 0 {
      formBottomConstraint.constant = 0
    } else {
      formBottomConstraint.constant += keyboardOriginDelta
    }

    view.setNeedsUpdateConstraints()

    UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: {
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
}

