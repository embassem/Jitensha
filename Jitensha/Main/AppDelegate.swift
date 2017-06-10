//
//  AppDelegate.swift
//  Jitensha
//
//  Created by Bassem Abbas on 6/7/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import GoogleMaps
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        _                                           = self.configer(application, didFinishLaunchingWithOptions: launchOptions);


        return true
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

extension AppDelegate {


    func configer(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UIApplication.shared.statusBarStyle         = .lightContent

        self.configerGoogleMaps();
        //Uncomwnt if require notification
       // self.configerRemoteNotification(application: application);
        LocationService.requestWhenInUseAuthorization();
        self.InitCorrectView()

       // Fabric.with([Crashlytics.self])

        return true
    }

    func InitCorrectView() {

        let authorize                               = Helper.Authorize.loginResponse
        if (authorize != nil) {
            ViewControllers.setClientMainView(application: self)

           // Do any work Related with App Lunch


        } else {
            //TODO: FixAfter Login with service
            ViewControllers.SetClientLoginView(application: self)
            //            ViewControllers.setClientMainView(application: self)

        }

    }

    //Configer Google Map;
    fileprivate func configerGoogleMaps() {
        GMSServices.provideAPIKey(Config.GOOGLE_MAP_API_KEY);
    }

    func configerRemoteNotification(application: UIApplication) {

        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions     = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in })

            // For iOS 10 data message (sent via FCM)
//            FIRMessaging.messaging().remoteMessageDelegate = self

        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()

        // [START add_token_refresh_observer]
        // Add observer for InstanceID token refresh callback.

//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(self.tokenRefreshNotification),
//                                               name: .firInstanceIDTokenRefresh,
//                                               object: nil)
        // [END add_token_refresh_observer]

    }

    func configerDidEnterBackground(_ application: UIApplication) {
        LocationService.shared.appDidBecomeActive()
    }


    func configerDidBecomeActive (_ application: UIApplication) {
        LocationService.shared.appDidBecomeActive()
    }


}


// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewNotification"), object: nil, userInfo: nil);

        // Change this to your preferred presentation option
        completionHandler([.sound,.badge,.alert])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo                                = response.notification.request.content.userInfo
                print(userInfo)

        completionHandler()
    }
}
// [END ios_10_message_handling]


