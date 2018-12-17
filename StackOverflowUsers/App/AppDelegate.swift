//
//  AppDelegate.swift
//  StackOverflowUsers
//
//  Copyright © 2018 Daniel Bastidas. All rights reserved.
//

import UIKit
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let bundle = Bundle(for: StackListViewController.self)
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: bundle, container: container)
        window?.rootViewController = storyboard.instantiateInitialViewController()
        
        return true
    }
}

