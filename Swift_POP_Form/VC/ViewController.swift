//
//  ViewController.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import RP_iosBootstrap

class ViewController: UIViewController {
  
  lazy var form: PopForm_ViewController = {
    let form = PopForm_ViewController(dataSource: self.formDataSource)
    form.delegate = self
    return form
  }()
  
  lazy var formDataSource: LocalFormDataSource = LocalFormDataSource()
  
  override func loadView() {
    view = UIView()
    view.backgroundColor = UIColor.black
    
    addChildViewController(form)
    view.addSubview(form.view)
    form.view.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
    form.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    form.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
    let totalFormHeight = formDataSource.fields.reduce(CGFloat(0), { $0 + $1.theme.height })
    form.view.heightAnchor.constraint(equalToConstant: totalFormHeight).isActive = true
  }
}

extension ViewController: PopForm_ViewControllerDelegate {
  func formWasValidated(callback: PopForm_ValidationCallback) {
    print(callback)
  }
}
