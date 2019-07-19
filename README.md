**POP! A form builder written in Swift**
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A basic form creation system that uses MVVM and POP to quickly create and customize iOS forms

It uses [SwiftValidator](https://github.com/SwiftValidatorCommunity/SwiftValidator) and for it's validation

**Documentation** 

Regularly updated documentation can be found here [bikisdesign.github.io/Swift_POP_Form](https://bikisdesign.github.io/Swift_POP_Form/)

**Quick Start Guide**

Let's start by creating a textfield's datasource:

```swift
private struct FirstName_Field: PopFormFieldDataSource {
  var prefilledText: String?

  var theme: PopFormFieldTheme = TextFieldTheme()

  var placeholder: String = "First Name"

  var apiKey: String = "firstName"

  var validationRule: [Rule]? = [RequiredRule(message: "First Name is Required")]

  var returnKey: UIReturnKeyType? = .next

  var autoCapitilization: UITextAutocapitalizationType = .words
}
```

We can even do date pickers or custom picker views as inputViews
```swift
private struct BirthdayDatePickerDataSource: PopFormDatePickerDataSource {
  var startDate: Date? = nil

  var restrictedDateRange: (Date, Date)? = nil

  var shouldPrefillStartDate: Bool = false

  var formatForDisplayedDate: (Date) -> String = {
    let df = DateFormatter()
    df.dateFormat = "MM"
    let month = df.string(from: $0)
    df.dateFormat = "dd"
    let day = df.string(from: $0)
    df.dateFormat = "yy"
    let year = df.string(from: $0)
    return "\(day).\(month).\(year)"
  }
}
```

Then add some field styling:

```swift
private struct TextFieldTheme: PopFormFieldTheme {

  var focusedColor: UIColor = UIColor.lightGray

  var textfieldFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .light)
  
  var borderOpacity: Float = 0.85
  
  var textAlignment: NSTextAlignment = .center
  
  var borderIsUnderline: Bool = false
  
  var errorColor: UIColor = .red
  
  var backgroundColor: UIColor = UIColor.white
  
  var textColor: UIColor = UIColor.black
  
  var placeholderTextColor: UIColor = UIColor.lightGray
  
  var borderColor: UIColor = UIColor.lightGray
  
  var borderWidth: CGFloat = 0.5
  
  var height: CGFloat = 65

  var textFieldHeight: CGFloat = 60

  var textViewHeight: CGFloat = 120

  var cursorColor: UIColor = UIColor.blue
}
```

Now add styling for the form itself:

```swift
private struct FormTheme: PopFormTheme {
  var backgroundColor: UIColor = .white
  var formColor: UIColor = .white
}
```



Now create your form:

```swift
struct PersonalInformationForm: PopFormDataSource {
  var fields: PopFormFields = [FirstName_Field(),
                               LastName_Field(),
                               Zip_Field(),
                               PhoneNumber_Field(),
                               Occupation_Field(),
                               Notes_Field(),
                               Birthday_Field()]
  
  var theme: PopFormTheme = FormTheme()
}
```




Lastly, create an instance of a *PopFormViewController* and pass the form datasource to it:

```swift
private lazy var formVC: PopFormViewController = {
    let f = PopFormViewController(dataSource: formDataSource)
    f.delegate = self
​    return f
  }()
```

![Sucess Demo](https://raw.githubusercontent.com/bikisDesign/Swift_POP_Form/master/demos/popFormDemo.gif)
![Fail Demo](https://raw.githubusercontent.com/bikisDesign/Swift_POP_Form/master/demos/popFormFailDemo.gif)


