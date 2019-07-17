//
//  UIColor-Ext.swift
//  RP_iosBootstrap
//
//  Created by Aaron bikis on 6/30/16.
//  Copyright © 2016 Aaron bikis. All rights reserved.
//

import UIKit

extension UIColor {
  public convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
    let red = r/255.0
    let green = g/255.0
    let blue = b/255.0
    self.init(red: red, green: green, blue: blue, alpha: 1.0)
  }
  
  public func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
      return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
}
