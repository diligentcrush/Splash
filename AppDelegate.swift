//
//  AppDelegate.swift
//  Splash
//
//  Created by Keshav Pothireddy on 11/17/18.
//  Copyright © 2018 UWAVES. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let authListener = Auth.auth().addStateDidChangeListener{ auth, user in
            
            if user != nil {
                UserService.observeUserProfile(user!.uid) {userProfile  in
                    UserService.currentUserProfile = userProfile
                }
                //
            } else {
                UserService.currentUserProfile = nil
            }
        }
  
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
     
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

