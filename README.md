# KNImageButton

KNImageButton is a customize button that can contain Image and Title
Support Xcode 8 & Swift 3.0

**How to use** 

Download project and drag KNImageButton class to your project

*Code*

~~~~
let customButton = KNImageButton(frame: CGRect(x: 10, y: 100, width: 365, height: 80))
customButton.cornerRadius = 10
customButton.borderColor = UIColor.black
customButton.borderWidth = 1
customButton.title = "This button created by code"
customButton.image = UIImage(named: "icon")
customButton.addTarget(target: self, action: #selector(button_Tapped), for: .touchUpInside)

self.view.addSubview(customButton)
~~~~

*Interface builder with autolayout*
* Use a View
* Change class to KNImageButton
* Adjust some value base on your idea

**Examples** 

A working demonstration is included inside folder.

*Please give me feedback if you have any issue.
Thank you for using my repo.*
