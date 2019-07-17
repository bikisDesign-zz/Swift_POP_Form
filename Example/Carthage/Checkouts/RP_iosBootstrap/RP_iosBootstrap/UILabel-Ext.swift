//
//  UILabel-Ext.swift
//  InnerPro
//
//  Created by Aaron bikis on 10/24/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

extension UILabel {
  public func addColoringHighlighting(text: String, textToColor: String, font: UIFont, defaultColor: UIColor, highlightColor: UIColor){
    let darkText = [NSAttributedString.Key.foregroundColor: defaultColor, NSAttributedString.Key.font: font]
    
    let range = text.range(of: textToColor)!
    let nsrange = NSRange(range, in: textToColor)
    let attr = NSMutableAttributedString(string: text, attributes: darkText)
    attr.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightColor, range: nsrange)
    self.attributedText = attr
  }
}
