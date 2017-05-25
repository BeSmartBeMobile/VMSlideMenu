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
            MenuTab(icon: #imageLiteral(resourceName: "tab1"), selectionColor: UIColor.orange, options: [
                MenuOption(withName: "Opcion 1", image: #imageLiteral(resourceName: "option1"), action: { print("opción 1 pulsada") })
                ]),
            MenuTab(icon: #imageLiteral(resourceName: "tab2"), selectionColor: UIColor.white, options: [
                MenuOption(withName: "Opcion 1", image: #imageLiteral(resourceName: "option1"), action: { print("opción 1 pulsada") }),
                MenuOption(withName: "Opcion 2", image: #imageLiteral(resourceName: "option2"), action: { print("opción 2 pulsada") })
                ]),
            MenuTab(icon: #imageLiteral(resourceName: "tab3"), selectionColor: UIColor.red, options: [
                MenuOption(withName: "Opcion 1", image: #imageLiteral(resourceName: "option1"), action: { print("opción 1 pulsada") }),
                MenuOption(withName: "Opcion 2", image: #imageLiteral(resourceName: "option2"), action: { print("opción 2 pulsada") }),
                MenuOption(withName: "Opcion 3", image: #imageLiteral(resourceName: "option3"), action: { print("opción 3 pulsada") })
                ]),
            MenuTab(icon: #imageLiteral(resourceName: "tab4"), selectionColor: UIColor.green, options: [
                MenuOption(withName: "Opcion 1 superlarga probando titulo halamadriddd", image: #imageLiteral(resourceName: "option1"), action: { print("opción 1 pulsada") }),
                MenuOption(withName: "Opcion 2", image: #imageLiteral(resourceName: "option2"), action: { print("opción 2 pulsada") }),
                MenuOption(withName: "Opcion 3", image: #imageLiteral(resourceName: "option3"), action: { print("opción 3 pulsada") }),
                MenuOption(withName: "Opcion 4", image: #imageLiteral(resourceName: "option4"), action: { print("opción 4 pulsada") })/*,
                MenuOption(withName: "Opcion 1", image: #imageLiteral(resourceName: "option1"), action: { print("opción 1 pulsada") }),
                MenuOption(withName: "Opcion 2", image: #imageLiteral(resourceName: "option2"), action: { print("opción 2 pulsada") }),
                MenuOption(withName: "Opcion 3", image: #imageLiteral(resourceName: "option3"), action: { print("opción 3 pulsada") }),
                MenuOption(withName: "Opcion 4", image: #imageLiteral(resourceName: "option4"), action: { print("opción 4 pulsada") })*/
                ])
        ]
        
        let menuViewController = VMSlideMenuViewController(withTabs: tabs)
        menuViewController.backgroundColor = UIColor.cyan
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = menuViewController
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

