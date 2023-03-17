//
//  AppDelegate.swift
//  AudiFakeUIKitApp
//
//  Created by jcruzsa on 16/03/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: CarSelectionViewController(nibName: String(describing: CarSelectionViewController.self), bundle: Bundle(for: type(of: self))))
        window?.makeKeyAndVisible()
        
        return true
    }
}

