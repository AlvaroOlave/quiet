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
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var mainWireframe: ALMainViewWireframeProtocol!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        startApp()
        
        FBSDKAppLinkUtility.fetchDeferredAppLink { (url, error) in
            if let url = url {
                application.open(url, options: [UIApplication.OpenExternalURLOptionsKey : Any](), completionHandler: nil)
            }
        }
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        
        return handled
    }

    func applicationWillResignActive(_ application: UIApplication) {
        mainWireframe.view.presenter.viewWillDisappear()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        if UIApplication.shared.keyWindow?.rootViewController?.presentedViewController == nil {
            mainWireframe.view.presenter.viewDidAppear()
        }
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
        if (UserDefaults.standard.object(forKey: "AL_FIRST_APP_LOAD") == nil) {
            UserDefaults.standard.set(Date(), forKey: "AL_FIRST_APP_LOAD")
        }
    }

    private func createWindow() -> UIWindow? {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        return window
    }
}

