//
//  KeyboardNotifiable.swift
//  RP_iosBootstrap
//
//  Created by Aaron bikis on 6/30/16.
//  Copyright © 2016 Aaron bikis. All rights reserved.
//

import UIKit

/**
 *Methods:*
 - registerForKeyboardNotifications(selector:)
 - keyboardWillShowOrHide(notification:)
 - unregisterForKeyboardNotifications()
 */
public protocol KeyboardNotifiable {
  
  /**
   Will register the reciever that conforms to *KeyboardNotifiable* to the following notifications:
   - UIKeyboardWillShow
   - UIKeyboardWillHide
   - UIKeyboardDidHide
 */
  func registerForKeyboardNotifications(with selector: Selector)
  
  func keyboardWillShowOrHide(_ notification: NSNotification)
}

extension KeyboardNotifiable where Self: UIViewController {
  public func registerForKeyboardNotifications(with selector: Selector){
    let center = NotificationCenter.default
    center.addObserver(self, selector: selector, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    center.addObserver(self, selector: selector, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    center.addObserver(self, selector: selector, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
  }
  
  public func unregisterForKeyboardNotifications(){
    let center = NotificationCenter.default
    center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    center.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    center.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
  }
}



