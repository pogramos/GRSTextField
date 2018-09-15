# GRSTextField

<p align="center">
  supports
</p>

## Usage
---
There are two ways of using the Field, one of them (and most convenient) is to use it with Interface Builder (IB). You can drag a UITextField to the view and then set its class as GRSTextField, after that you'll see a bunch of attributes that you can mess with and preview your changes on the IB.

<p align="center">
  <img src="Screenshots/properties_panel.png" alt="Properties Panel" style="height:350px"/>
</p>

### Code

To set the error label as the outlet of the Field, just drag a label wherever you want on your storyboard (or xib), select your Text Field, go to the connections inspector and link it with the "errorLabel" outlet.

<p align="center">
  <img src="Screenshots/connections_panel.png" alt="Connections Panel"/>
</p>

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

In case you want to set your field's value and then have it masked right after it loads

```swift
textField.text = "1234567"
textField.applyMask()
```

## Properties Explanation

### _Inspectables_
##### Mask Pattern
Whenever you want to make your field accept only numeric numbers and limit its maximum characters at the same time, set a mask for it. If you set a mask to your field it will automatically change your keyboard type to `.numberPad`.
e.g.: ####-### will turn 1234567 into 1234-567
##### Error Message Key
Will use the message set on this property as the text on your error label outlet.*
##### Has Border
Toggle the bottom line on the field.
##### Max characters
In case your field accepts alphanumerics and you want to set a maximum of characters for it, give this property a number to deal with, but only if your **Mask Pattern** property is empty, otherwise the field will prioritize the pattern property and ignore this one.

### _Not inspectables_
##### Valid
(#valid)

This property will determine wether your field was correctly filled or not. By default this property will be set to false whenever your field is empty and you have an error message, error label set.

You can also set this property as you wish on your code with a custom validation.

## Colors
The colors blow will be applied on both the border and the error label (or hint)

#### *<p style="color:red">Error Color</p>*
By default this color is <span style="color:red">red</span>. This will be applied when the field is empty or the "[valid](#valid)" property is set to false

#### *<p style="color:gray">Border Color</p>*
By default this color is <span style="color:gray">gray</span>. This will be applied when the field is idle and correctly set.

#### *<p style="color:blue">Selected Color</p>*
By default this color is <span style="color:blue">blue</span>. This will be applied when the field is valid and selected.

## Current support

Language: Swift 4

If you need/want to use an older version of this field there's an Objective-C version of it on [GRTextField](http://github.com/pogramos/GRTextField)

## License
GRSTextField is available under the MIT license. See the LICENSE file for more info.
