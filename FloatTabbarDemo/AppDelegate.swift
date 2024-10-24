//
//  AppDelegate.swift
//  FloatTabbarDemo
//
//  Created by mac on 2024/10/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .blue
        window?.makeKeyAndVisible()
        
        window?.rootViewController = FloatingTabBarController()
        
        
        return true
    }



}

