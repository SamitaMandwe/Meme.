//
//  AppDelegate.swift
//  MEME Part-1
//
//  Created by Samita Mandwe on 10/21/17.
//  Copyright © 2017 udacity. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var memes = [Meme]()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

