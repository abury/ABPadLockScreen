<p align="center" >
  <img src="http://www.aronbury.com/assets/images/ab_logo.png" alt="ABLogo" title="ABLogo">
</p>

[![Twitter: @AronBury](https://img.shields.io/badge/contact-@AronBury-blue.svg?style=flat)](https://twitter.com/AronBury)
[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/abury/ABPadLockScreen/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/abury/ABPadLockScreen.png)](https://travis-ci.org/abury/ABPadLockScreen)
![Version](https://img.shields.io/cocoapods/v/ABPadLockScreen.svg)

ABPadLockScreen aims to provide a universal solution to providing a  secure keypad/pin lock screen to your iPhone or iPad app. With just a few lines you can have a full lock screen module ready to go.

## Features
- Supports iPhone and iPad
- Allows the user to set their PIN
- Optional PIN entry limit
- Optional cancel button
- Optional text modification
- Optional pin length (default is 4)
- Full appearance customisation

<img src="http://www.aronbury.com/assets/images/abpadlockscreen/fb-blue.png" width=50% alt="screenshot" title="screenshot">

## Installation with Cocoapods
[CocoaPods](http://cocoapods.org) is the easiest way to manage your iOS/OSX dependencies. Check out their getting started guide to see how to set it up.
If you have cocoapods setup on your machine, simply set the spec like this:

#### Podfile
```ruby
platform :ios, '6.0'
pod "ABPadLockScreen", "~> 3.3.0"
```
The earliest version of this framework that supports cocoapods is 3.0.0

## Customising the Appearance
The module is entirely customisable through UIAppearance. All colours and fonts used within the module can be set using the UIAppearance proxy. The example project shows how to do this, but for a more in depth look at UIAppearance check out the docs [check out the docs](https://developer.apple.com/library/ios/documentation/uikit/reference/UIAppearance_Protocol/Reference/Reference.html) or check out [Matt Thompson’s article on NSHipster](http://nshipster.com/uiappearance/)

<img src="http://aronbury.com/assets/images/abpadlockscreen/custom_red.jpg" width=50% alt="Custom Text" title="Custom Text">
<img src="http://www.aronbury.com/assets/images/abpadlockscreen/gray-locked.png" width=50% alt="Locked out" title="Locked out">

## Contributing
I love seeing people contribute to the ABPadLockscreen. It's had some great new features already contributed by some talented folks. If you want to contribute please issue a pull request to the develop branch of this repository. I'll review them and if it looks good we'll merge and push it in the next release!

## License
ABPadLockScreen is available under the MIT license. See the LICENSE file for more info.
