//
//  AppDelegate.swift
//  xcoders
//
//  Created by Ammar AlTahhan on 06/04/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import UIKit
import GoogleMaps
import IQKeyboardManagerSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    let GMKey = "AIzaSyBUpuGatJADOfdOS7kxokwfHx1kfGQMkgo"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        ////////only for yarob's env :
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "login")
//        
//        self.window?.rootViewController = initialViewController
//        self.window?.makeKeyAndVisible()
        ////////////////////////////////
        
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey(GMKey)
        IQKeyboardManager.sharedManager().enable = true
        
        Appearance.setGlobalAppearance()
        
        //SHOULD BE CALLED AFTER ONBOARDING
        registerForPushNotifications()
        
        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
            let aps = notification["aps"] as! [String: AnyObject]
            handlePushNotification(aps)
        }
        
        UNUserNotificationCenter.current().delegate = self


        return true
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            
            
            let acceptAction = UNNotificationAction(identifier: "acceptActionIdentifier",
                                                  title: "Accept",
                                                  options: [.foreground])
            

            let incidentsCategory = UNNotificationCategory(identifier: "incidentsCategoryIdentifier",
                                                      actions: [acceptAction],
                                                      intentIdentifiers: [],
                                                      options: [])

            UNUserNotificationCenter.current().setNotificationCategories([incidentsCategory])
            
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.sync {
                UIApplication.shared.registerForRemoteNotifications()
            }
            
        }
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let deviceToken = tokenParts.joined()
        print("Device Token: \(deviceToken)")
        APNService.addToken(deviceToken) { (err) in
            guard err == nil else { return }
        }
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let aps = userInfo["aps"] as! [String: AnyObject]
        handlePushNotification(aps)
    }
    
    func handlePushNotification(_ aps: [String: AnyObject]) {
        print(aps)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

let defaults = UserDefaults.standard

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        let aps = userInfo["aps"] as! [String: AnyObject]
        if response.notification.request.content.categoryIdentifier == "incidentsCategoryIdentifier" {
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                print(response.actionIdentifier)
                completionHandler()
            case "acceptActionIdentifier":
                print(response.actionIdentifier)
                completionHandler()
            default:
                break;
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
}
