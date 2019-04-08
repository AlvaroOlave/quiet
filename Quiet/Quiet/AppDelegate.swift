//
//  AppDelegate.swift
//  Quiet
//
//  Created by Alvaro on 20/11/2018.
//  Copyright © 2018 surflabapps. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var mainWireframe: ALMainViewWireframeProtocol!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        startApp()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        mainWireframe.view.presenter.viewWillDisappear()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
//        mainWireframe.view.presenter.viewDidAppear()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //MARK:- privateMethods
    
    private func startApp() {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        if let window = createWindow() {
            mainWireframe = mainFactory()
            mainWireframe.presentMainViewInWindow(window)
        }
        ALPurchaseManager.shared.start()
    }

    private func createWindow() -> UIWindow? {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        return window
    }
}

