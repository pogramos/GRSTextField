# GRSTextField

## Usage
---

There are two ways of using the Field, one of them (and most convenient) is to use it with Interface Builder (IB). You can drag a UITextField to the view and then set its class as GRSTextField, after that you'll see a bunch of attributes that you can mess with and preview your changes on the IB.

[Photo 1]

To set the error label as the outlet of the Field, just drag a label wherever you want on your storyboard (or xib), select your Text Field, go to the connections inspector and link it with the "errorLabel" outlet.


[Photo 2]

There's also a way to set some of the properties by code

```swift
// Initialize the field setting the rect for its frame
let textField = GRSTextField(frame: rect)

// Sets the mask pattern for the field
textField.maskPattern = "####-###"

// Set the maximum number of characters for the Field
// it will be ignored if the field has a mask pattern
textField.maxCharacters = 8

// Defines if the will will have borders or not
textField.hasBorders = true

// Error message that will be shown on your error label
textField.errorMessage = "Required field"

// If you want to setup an error label to your field
textField.errorLabel = errorLabel
```
