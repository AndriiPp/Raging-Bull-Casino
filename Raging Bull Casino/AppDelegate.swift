//
//  AppDelegate.swift
//  Raging Bull Casino
//
//  Created by Nutella on 08.12.2021.
//

import UIKit
import Firebase
import FBSDKCoreKit
import OneSignal
import AppTrackingTransparency
import AdSupport

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var orientationLock = UIInterfaceOrientationMask.all

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        

        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized: break
                @unknown default:
                    print("Unknown")
                }
            }
        }
        FirebaseApp.configure()
        
        
        //MARK:- Facebook deeplink
        AppLinkUtility.fetchDeferredAppLink { (url, error) in
        if let error = error {
        } else if let mainStr = url?.absoluteString {
            if  let range  = mainStr.range(of: "run?"){
                 var str = String(mainStr[range.upperBound...])
                 let strArr = str.components(separatedBy: "&al_applink")
                 str = strArr[0]
             let strArr1 = str.split(separator: "&", maxSplits: 1).map(String.init)
             UserDefaults.standard.set(strArr1[0], forKey: "referrer1")
             UserDefaults.standard.set(strArr1[1], forKey: "referrer2")
            }
            
        } else {
            }
        }
        
        //MARK: - OneSignal
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)

          // OneSignal initialization
          OneSignal.initWithLaunchOptions(launchOptions)
          OneSignal.setAppId("f455045c-793f-4a32-b903-33d6f3e04f59")
          OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
          })
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

