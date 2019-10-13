//
//  AppDelegate.swift
//
//  Created by Shady Mustafa on 16.07.19.

//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil else { return true }

        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let loadingViewController = LoadingViewController.make()
        loadingViewController.viewModel.inputs.configure(with: ImageGalleryContentProvider())
       
        self.window?.rootViewController = loadingViewController
        self.window?.makeKeyAndVisible()

        return true
    }
}
