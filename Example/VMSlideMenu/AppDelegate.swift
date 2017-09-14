//
//  AppDelegate.swift
//  VMSlideMenu
//
//  Created by Jorge Lucena on 05/18/2017.
//  Copyright (c) 2017 Jorge Lucena. All rights reserved.
//

import UIKit
import VMSlideMenu

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let tabs = [
            MenuTab(icon: #imageLiteral(resourceName: "tab1"),
                    selectionColor: UIColor.orange,
                    options: [ MenuOption(withName: "Opcion 1",
                                          image: #imageLiteral(resourceName: "option1"),
                                          action: { print("opción 1.1 pulsada") })
                ]),

            MenuTab(icon: #imageLiteral(resourceName: "tab2"),
                    selectionColor: UIColor.white,
                    options: [ MenuOption(withName: "Opcion 1",
                                          image: #imageLiteral(resourceName: "option1"),
                                          action: { print("opción 2.1 pulsada") }),

                               MenuOption(withName: "Opcion 2",
                                          image: #imageLiteral(resourceName: "option2"),
                                          action: { print("opción 2.2 pulsada") })
                ]),

            MenuTab(icon: #imageLiteral(resourceName: "tab3"),
                    selectionColor: UIColor.red,
                    options: [ MenuOption(withName: "Imputar horas",
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
                    options: [ MenuOption(withName: "Opcion 1",
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

        let menuViewController = VMSlideMenuViewController(withTabs: tabs)
        menuViewController.backgroundColor = UIColor.blue

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = menuViewController

        return true
    }
}
