//
//  AppDelegate.swift
//  Marvelgram
//
//  Created by Tim Akhm on 07.02.2022.
//

import UIKit

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
   
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainVC = ModelBuilder.createMainModule()
        
        let mainNavigationController = UINavigationController(rootViewController: mainVC)
        window.rootViewController = mainNavigationController
        window.makeKeyAndVisible()
        
        self.window = window
        return true
    }
}

