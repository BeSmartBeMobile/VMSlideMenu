# VMSlideMenu

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://gitlab.vectoritcgroup.com/ios-modules/VMSlideMenu/blob/master/LICENSE)
[![Versión de pod](https://img.shields.io/badge/pod-1.0.5-green.svg)](https://gitlab.vectoritcgroup.com/ios-modules/VMSlideMenu/commits/1.0.5)

![VMSlideMenu](VMSlideMenu.gif)

VMSlideMenu allows add a beautyful and intuitive menu to your app. You can organize options in tabs and rows, and customize colors.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 3+
- iOS 9+ 


## Installation

VMSlideMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'VMSlideMenu'
```

## Use

First, import the library:

```swift
import VMSlideMenu
```

Then create the tabs and options hierarchy:

```swift
let tabs = [
    MenuTab(icon: #imageLiteral(resourceName: "tab1"),
            selectionColor: UIColor.orange,
            options: [ MenuOption(withName: "Opcion 1",
            image: #imageLiteral(resourceName: "option1"),
            action: { print("opción 1.1 pulsada") })
    ]),

    MenuTab(icon: #imageLiteral(resourceName: "tab2"),
        selectionColor: UIColor.white,
        options: [

        MenuOption(withName: "Opcion 1",
            image: #imageLiteral(resourceName: "option1"),
            action: { print("opción 2.1 pulsada") }),

        MenuOption(withName: "Opcion 2",
            image: #imageLiteral(resourceName: "option2"),
            action: { print("opción 2.2 pulsada") })
        ]),

    MenuTab(icon: #imageLiteral(resourceName: "tab3"),
        selectionColor: UIColor.red,
        options: [ 
        
        MenuOption(withName: "Imputar horas",
            image: #imageLiteral(resourceName: "option1"),
            action: { print("opción 3.1 pulsada") }),

        MenuOption(withName: "Reportar gastos",
            image: #imageLiteral(resourceName: "option2"),
            action: { print("opción 3.2 pulsada") }),

            MenuOption(withName: "Mi perfil",
            image: #imageLiteral(resourceName: "option3"),
            action: { print("opción 3.3 pulsada") })
    ]),

    MenuTab(icon: #imageLiteral(resourceName: "tab4"),
        selectionColor: UIColor.green,
        options: [ 
        
        MenuOption(withName: "Opcion 1",
            image: #imageLiteral(resourceName: "option1"),
            action: { print("opción 4.1 pulsada") }),

        MenuOption(withName: "Opcion 2",
            image: #imageLiteral(resourceName: "option2"),
            action: { print("opción 4.2 pulsada") }),

        MenuOption(withName: "Opcion 3",
            image: #imageLiteral(resourceName: "option3"),
            action: { print("opción 4.3 pulsada") }),

        MenuOption(withName: "Opcion 4",
            image: #imageLiteral(resourceName: "option4"),
            action: { print("opción 4.4 pulsada") })
    ])
]
```

Finally create your VSMenuViewController and present it where you need:

```swift
let menuViewController = VMSlideMenuViewController(withTabs: tabs)
menuViewController.backgroundColor = UIColor.blue
```

## Authors

José María Ila, jmila@vectoritcgroup.com (Original Objective-C code)

Jorge Lucena, jmlucena@vectoritcgroup.com (Swift translation, framework packaging)

## License

VMSlideMenu is available under the MIT license. See the [LICENSE](https://gitlab.vectoritcgroup.com/ios-modules/VMSlideMenu/blob/master/LICENSE) file for more info.

## Further Information
For more information on the project, please write to [vectormobility@gmail.com](mailto://vectormobility@gmail.com).
