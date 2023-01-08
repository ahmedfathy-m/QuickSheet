# QuickSheet

## What is it?
QuickSheet is a wrapper for UIViewController to handle bottom sheet presentation (a.k.a pop-ups) with low code footprint and a high degree of customisation.

## Why do you need it?
Bottom Sheet / Pop-up view presentation in iOS is only available (natively) in iOS 15 with limited functionality that's only expanded upon in iOS 16. Attempting to replicate the effect in prior versions of iOS could include adding multiple modifications to how you build your views and view controllers that might make it more difficult to migrate to the native soultion when it hits the mainstream especially in large scale applications.

[![CI Status](https://img.shields.io/travis/Ahmed%20Fathy/QuickSheet.svg?style=flat)](https://travis-ci.org/Ahmed%20Fathy/QuickSheet)
[![Version](https://img.shields.io/cocoapods/v/QuickSheet.svg?style=flat)](https://cocoapods.org/pods/QuickSheet)
[![License](https://img.shields.io/cocoapods/l/QuickSheet.svg?style=flat)](https://cocoapods.org/pods/QuickSheet)
[![Platform](https://img.shields.io/cocoapods/p/QuickSheet.svg?style=flat)](https://cocoapods.org/pods/QuickSheet)

## Usage
You can present the target view controller without any modifications to it by calling `self.presentQuickSheet` method with the standard options
```
self.presentQuickSheet(targetVC, options: .standard)
```

## Customisations
You can customise the presentation by creating a new options constant
```
let customOptions = QuickSheetOptions(fraction: 0.3,
                                      isExpandable: true,
                                      isScrollable: true,
                                      cornerRadius: 10,
                                      blurEffect: .systemMaterial,
                                      shadowStyle: .standard)
self.presentQuickSheet(targetVC, options: customOptions)
```

<a href="https://imgur.com/0liyj16"><img src="https://i.imgur.com/0liyj16l.png" title="source: imgur.com" /></a>
<a href="https://imgur.com/CQ4JYgb"><img src="https://i.imgur.com/CQ4JYgbl.png" title="source: imgur.com" /></a>
<a href="https://imgur.com/5MQ2v4Z"><img src="https://i.imgur.com/5MQ2v4Zl.png" title="source: imgur.com" /></a>
<a href="https://imgur.com/wFHANbD"><img src="https://i.imgur.com/wFHANbDl.png" title="source: imgur.com" /></a>
<img src="https://i.imgur.com/u4XsOX5.gif" width="295.5" />

Here's how you can use `QuickSheetOptions` to customise your pop-up
- `fraction`: Represents the height of the sheet as a percentage of the screen height
- `isExpandable`: Setting this option to `true` enables the pop-up to expand to a near full height
- `isScrollable`: Setting this option to `true` enables scrolling in the content view
- `cornerRadius`: Changing this value determines the radius of the top left and right corners
- `blurEffect`: Choose a background effect from a system-defined list `UIBlurEffect.Style`
- `shadowStyle`: Determines the shadow style of the pop-up. Set to `.standard` to use the default configuration or create your own `QuickSheetOptions.ShadowStyle` constant as follows
```
let shadowStyle = QuickSheetOptions.ShadowStyle(shadowRadius: 10.0,
                                                  shadowColor: .black,
                                                  shadowOpacity: 0.25)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

QuickSheet is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'QuickSheet'
```

## Author

Ahmed Fathy, ahmedfathy.mha@gmail.com

## License

QuickSheet is available under the MIT license. See the LICENSE file for more info.
