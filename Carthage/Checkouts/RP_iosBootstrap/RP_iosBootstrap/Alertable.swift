//
//  Alertable.swift
//  RP_iosBootstrap
//
//  Created by Aaron bikis on 6/30/16.
//  Copyright © 2016 Aaron bikis. All rights reserved.
//

import UIKit
/**
 An alert to be passed show(alert:) methods on UIViewControllers that conform to Alertable
 */
public protocol SVNAlert {
  var title: String { get }
  
  var message: String { get }
  
  var confirmationTitle: String { get }
  
  var denialTitle: String { get }
}


extension SVNAlert {
  public var confirmationTitle: String { return "" }
  
  public var denialTitle: String { return "" }
}

/**
 *Methods:*
 - show(alert:)
 - show(optionalAlert:)
 */
public protocol Alertable {}


extension Alertable where Self: UIViewController {
  
  public func show(alertWithType alertType: SVNAlert, withCompletionHandler handler: ((_ finished: Bool) ->())?) {
    let alert = UIAlertController(title: alertType.title, message: alertType.message, preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK",
                                 style: .cancel) { (alert) -> Void in
                                  if handler != nil {
                                    handler!(true)
                                  }
    }
    alert.addAction(okButton)
    DispatchQueue.main.async {
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  public func show(optionalAlertWith alertType: SVNAlert, handler: @escaping (_ accepted:Bool) -> ()) {
    let alert = UIAlertController(title: alertType.title, message: alertType.message, preferredStyle: .alert)
    let accept = UIAlertAction(title: alertType.confirmationTitle, style: .cancel) { (UIAlertAction) in
      handler(true)
    }
    let decline = UIAlertAction(title: alertType.denialTitle, style: .destructive) { (UIAlertAction) in
      handler(false)
    }
    alert.addAction(accept)
    alert.addAction(decline)
    
    DispatchQueue.main.async {
      self.present(alert, animated: true, completion: nil)
    }
  }
}
