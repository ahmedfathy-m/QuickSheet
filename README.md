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

You can customise the standard options at the app delegate after the app launch
```
    func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        QuickSheetOptions.standard = QuickSheetOptions(
                                    fraction: 0.75,
                                    presentationStyle: .regular,
                                    cornerRadius: 10,
                                    blurEffect: .regular,
                                    shadowStyle: .standard
                                    )
        return true
    }
```
Most of the settings you'd only need to change once. only the fraction and the presentation style depend on what kind of view you're presenting. So, now you have direct access to them without needing to create a custom options object to modify one or two parameters.
```
self.presentQuickSheet(targetVC, fraction: 0.5)
```
```
self.presentQuickSheet(targetVC, fraction: 0.5, presentationStyle: .scrollable)
```

## Customisations
You can customise the presentation by creating a new options constant
```
let customOptions = QuickSheetOptions(fraction: 0.3,
                                      presentationStyle: .expandable,
                                      cornerRadius: 10,
                                      blurEffect: .systemMaterial,
                                      shadowStyle: .standard)
self.presentQuickSheet(targetVC, options: customOptions)
```

<a href="https://imgur.com/0liyj16"><img src="https://i.imgur.com/0liyj16l.png" title="source: imgur.com" /></a>
<a href="https://imgur.com/CQ4JYgb"><img src="https://i.imgur.com/CQ4JYgbl.png" title="source: imgur.com" /></a>
<a href="https://imgur.com/5MQ2v4Z"><img src="https://i.imgur.com/5MQ2v4Zl.png" title="source: imgur.com" /></a>
<a href="https://imgur.com/wFHANbD"><img src="https://i.imgur.com/wFHANbDl.png" title="source: imgur.com" /></a>
![](https://media4.giphy.com/media/BCMDci08QPWeuKv2MM/giphy.gif)
![](https://media1.giphy.com/media/6AbFr1Dt0k2zSJGBbX/giphy.gif)

Here's how you can use `QuickSheetOptions` to customise your pop-up
- `fraction`: Represents the height of the sheet as a percentage of the screen height
- `presentationStyle`: The sheet's presentation style; regular, expandable or scrollable.
- `cornerRadius`: Changing this value determines the radius of the top left and right corners
- `blurEffect`: Choose a background effect from a system-defined list `UIBlurEffect.Style`. Setting this to nil removes the blur effect and replaces it with a 75% opaque black background
- `shadowStyle`: Determines the shadow style of the pop-up. Set to `.standard` to use the default configuration or create your own `QuickSheetOptions.ShadowStyle` constant as follows
```
let shadowStyle = QuickSheetOptions.ShadowStyle(shadowRadius: 10.0,
                                                shadowColor: .black,
                                                shadowOpacity: 0.25)
```

## Demo
- You can view the QuickSheet demo [here](https://www.youtube.com/watch?v=ejKw6xm64LA)
- To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

QuickSheet is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'QuickSheet'
```

## Contact Me
[![Email](https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:ahmedfathy.mha@gmail.com)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/ahmedfathy-mha/)

## License

QuickSheet is available under the MIT license. See the LICENSE file for more info.
