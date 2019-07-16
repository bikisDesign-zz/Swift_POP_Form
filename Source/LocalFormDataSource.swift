//
//  LocalFormDataSource.swift
//  Swift_POP_Form
//
//  Created by Aaron bikis on 5/14/18.
//  Copyright © 2018 Aaron bikis. All rights reserved.
//

import UIKit
import RP_iosBootstrap


struct LocalFormDataSource: PopFormDataSource {
  var fields: PopFormFields = <#code#>
  
  var theme: PopFormTheme = <#code#>
}


private struct FormTheme: PopFormTheme {
  var backgroundColor: UIColor = <#code#>
  var formColor: UIColor = <#code#>
}



private struct TextFieldTheme: PopFormFieldTheme {
  var backgroundColor: UIColor = <#code#>
  
  var textfieldFont: UIFont = <#code#>
  
  var borderOpacity: Float = <#code#>
  
  var textAlignment: NSTextAlignment = <#code#>
  
  var borderIsUnderline: Bool = <#code#>
  
  var errorColor: UIColor = <#code#>
  
  var backgroundColor: UIColor = <#code#>
  
  var textColor: UIColor = <#code#>
  
  var placeholderTextColor: <#code#>
  
  var borderColor: UIColor = <#code#>
  
  var borderWidth: CGFloat = <#code#>
  
  var height: CGFloat = <#code#>
}
