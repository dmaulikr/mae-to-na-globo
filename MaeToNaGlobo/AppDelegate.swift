//
//  AppDelegate.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/13/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import UIKit
import VisaCheckoutSDK
import Firebase
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        VisaCheckoutSDK.configure(environment: .sandbox, apiKey: "XU2ESDGNXWEYUV1KOEGY21SmpAAFDRAkjFoXqa0RK-hU2KjDA")
        FIRApp.configure()

        registerForRemoteNotification(for: application)

        listenForTokenChanges()

        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        FIRMessaging.messaging().disconnect()
        print("Disconnected from FCM.")
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification

        // Print full message.
        print(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(UNNotificationPresentationOptions.alert)
    }


    private func registerForRemoteNotification(for application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })

        // For iOS 10 data message (sent via FCM)
        FIRMessaging.messaging().remoteMessageDelegate = self

        application.registerForRemoteNotifications()
    }

    private func listenForTokenChanges() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification),
                                               name: .firInstanceIDTokenRefresh,
                                               object: nil)
    }


    func tokenRefreshNotification(_ notification: Notification) {
        if let refreshedToken = FIRInstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
        }

        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }

    func connectToFcm() {
        // Won't connect since there is no token
        guard FIRInstanceID.instanceID().token() != nil else {
            return
        }

        // Disconnect previous FCM connection if it exists.
        FIRMessaging.messaging().disconnect()

        FIRMessaging.messaging().connect { (error) in
            if error != nil {
                print("Unable to connect with FCM. \(error?.localizedDescription ?? "")")
            } else {
                print("Connected to FCM.")
            }
        }
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
}

extension AppDelegate: FIRMessagingDelegate {
    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {

    }
}

