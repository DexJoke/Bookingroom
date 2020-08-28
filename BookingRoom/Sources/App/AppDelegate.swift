//
//  AppDelegate.swift
//  BookingRoom
//
//  Created by Nguyễn Tùng Anh on 8/28/20.
//  Copyright © 2020 Nguyễn Tùng Anh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var instance : AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        self.window = UIWindow()
        
        return true
    }
}

