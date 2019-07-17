//
//  UImage-ext.swift
//  InnerPro
//
//  Created by Aaron bikis on 7/11/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit

extension UIImage {
  public func tint(with color: UIColor) -> UIImage {
    var image = withRenderingMode(.alwaysTemplate)
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    color.set()
    
    image.draw(in: CGRect(origin: .zero, size: size))
    image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
  }
}

