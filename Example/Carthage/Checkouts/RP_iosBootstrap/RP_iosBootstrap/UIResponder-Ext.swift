//
//  UIResponder-Ext.swift
//  InnerPro
//
//  Created by Aaron bikis on 7/28/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit


extension UIResponder {
  @objc public dynamic func tabTapped(_ tabID: String, onQueue queue: OperationQueue, sender: Any?) {
    coordinatingResponder?.tabTapped(tabID, onQueue: queue, sender: sender)
  }
}
