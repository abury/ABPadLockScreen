<p align="center" >
  <img src="http://www.aronbury.com/assets/images/ab_logo.png" alt="ABLogo" title="ABLogo">
</p>

[![Build Status](https://travis-ci.org/abury/ABPadLockScreen.png)](https://travis-ci.org/abury/ABPadLockScreen)

ABPadLockScreen aims to provide a universal solution to providing a  secure keypad/pin lock screen to your iPhone or ipad app. With just a few lines you can have a full lock screen module ready to go.

## Features
- Supports iPhone and iPad
- Allows the user to set their PIN
- Optional PIN entry limit
- Optional cancel button limit
- Optional title modification
- Full apperance customisation

<img src="http://www.aronbury.com/assets/images/abpadlockscreen/fb-blue.png" width=50% alt="screenshot" title="screenshot">

## Installation with Cocoapods
[CocoaPods](http://cocoapods.org)Cocoapods is the easiest way to manage your iOS/OSX dependencies. Check out their getting started guide to see how to set it up.
If you have cocoapods setup on your machine, simply set the spec like this:

#### Podfile
```ruby
platform :ios, '6.0'
pod "ABPadLockScreen", "~> 3.0"
```
The earliest version of this framework that supports cocoapods is 3.0.

## Customising the Apperance
The module is entirely customisable through UIAppearance. All colours and fonts used within the module can be set using the UIAppearance proxy. The example project shows how to do this, but for a more in depth look at UIAppearance check out the docs [check out the docs](https://developer.apple.com/library/ios/documentation/uikit/reference/UIAppearance_Protocol/Reference/Reference.html) or check out [Matt Thompsons article on NSHipster](http://nshipster.com/uiappearance/)

<img src="http://www.aronbury.com/assets/images/abpadlockscreen/fb-blue.png" width=50% alt="screenshot" title="screenshot">
<img src="http://www.aronbury.com/assets/images/abpadlockscreen/attempt-pink.png" width=50% alt="screenshot" title="screenshot">

## License
ABPadLockScreen is available under the MIT license. See the LICENSE file for more info.