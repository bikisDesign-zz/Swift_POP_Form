# POP! A Swift Form

This is a basic form creation library currently in its infant stages. It's uses on MVVM and POP to quickly create forms. 

It uses a slightly modified [SwiftValidator](https://github.com/SwiftValidatorCommunity/SwiftValidator) for it's Validation.

### Some Disclaimers:
This doesn't support Interface Builder, but does use Autolayout.

## To Use This Library
#### To create a POPForm you need field styling:

```
private struct TextFieldTheme: PopForm_FieldTheme {
  var backgroundColor: UIColor = UIColor.white

  var textColor: UIColor = UIColor.black

  var placeholderTextColor: UIColor = UIColor.lightText

  var borderColor: UIColor = UIColor.lightGray

  var borderWidth: CGFloat = 0.5

  var height: CGFloat = 65
}
```
#### Then create the fields you'd like in your form:

```
private struct FirstNameField: PopForm_FieldDataSource {
  var theme: PopForm_FieldTheme = TextFieldTheme()
  var apiKey: String = "first_name"
  var placeholder: String = "First Name"
  var validationRule: [Rule]? = [AlphaRule()]
  var returnKey: UIReturnKeyType = UIReturnKeyType.next
}


private struct LastNameField: PopForm_FieldDataSource {
  var theme: PopForm_FieldTheme = TextFieldTheme()
  var apiKey: String = "last_name"
  var placeholder: String = "Last Name"
  var returnKey: UIReturnKeyType = UIReturnKeyType.next
}


private struct PasswordField: PopForm_FieldDataSource {
  var theme: PopForm_FieldTheme = TextFieldTheme()
  var apiKey: String = "password"
  var placeholder: String = "Password"
  var validationRule: [Rule]? = [PasswordRule()]
  var isSecureEntry: Bool = true
  var returnKey: UIReturnKeyType = UIReturnKeyType.done
}
```
#### And then a general theme from for the form:
```
private struct FormTheme: PopForm_Theme {
  var backgroundColor: UIColor = UIColor(r: 64, g: 196, b: 255)
  var formColor: UIColor = UIColor(r: 130, g: 247, b: 255)
}
```

#### Lastly, create a full form model: 
```
struct LocalFormDataSource: PopForm_DataSource {
  var fields: PopForm_Fields = [FirstNameField(),
                                LastNameField(),
                                PasswordField()]

  var theme: PopForm_Theme = FormTheme()
}
```

#### Then instanciate and set up the FormVC:
```
let form = PopForm_ViewController(dataSource: LocalFormDataSource())
form.delegate = self
```

#### You'll hear back from the PopForm_ViewControllerDelegate if the form was correctly validated.
```
extension ViewController: PopForm_ViewControllerDelegate {
  func formWasValidated(callback: PopForm_ValidationCallback) {
  print(callback)
  }
}
```


## POPForm_ViewController Features
`shouldValidateOnLastFieldReturnKeyTap` if set to false then the last item in the form won't trigger validation.

