//
//  AppDelegate.swift
//
//

import Foundation
import UIKit
import SdkPushExpress
//import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
 private let PUSHEXPRESS_APP_ID = "40501-2" // set YOUR OWN ID from Push.Express account page
 private var myOwnDatabaseExternalId = ""      // you can just leave it empty in most cases
 
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
     
//     FirebaseApp.configure()
//     RemoteConfigManager.shared.fetchConfig()
     // Initialize SDK with PushExpress Application ID
     
     // For minimal initialization (without requesting notification perms
     // and registering for remote notifications) set 'essentialsOnly: true'
     try! PushExpressManager.shared.initialize(appId: PUSHEXPRESS_APP_ID, essentialsOnly: true)
     
     // To call only notification perms request, set 'registerForRemoteNotifications: false'
     // Do not call this if you will request permissions by yourself
     PushExpressManager.shared.requestNotificationsPermission(registerForRemoteNotifications: true)
     
     // DO NOT SET UNLESS YOU ARE 100% SURE WHAT THAT IS!!!
     /*
     myOwnDatabaseExternalId = "my_external_user_id:321"
     PushExpressManager.shared.tags["audiences"] = "my_aud_123"
     PushExpressManager.shared.tags["webmaster"] = "webmaster_name"
     PushExpressManager.shared.tags["ad_id"] = "advertising_id"
     PushExpressManager.shared.tags["my_custom_tag"] = "my_custom_value"
     */
     
     // You can also disable notifications while app is on screen (foreground)
     /*PushExpressManager.shared.foregroundNotifications = false*/
     
     // Activate SDK (starting all network activities)
     try! PushExpressManager.shared.activate(extId: myOwnDatabaseExternalId)
     print("externalId: '\(PushExpressManager.shared.externalId)'")
     
     // If and only if you want to use same app for multiple users
     // call .deactivate() first, than activate() with new extId
     // Better talk with our support, we always ready to help =)
     /*try! PushExpressManager.shared.deactivate()*/
     
     if !PushExpressManager.shared.notificationsPermissionGranted {
         // show your custom message like "Go to iOS Settings and enable notifications"
     }
     
     return true
 }
 
 func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
     let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
     PushExpressManager.shared.transportToken = tokenParts.joined()
 }
}

//
//
//
//import Foundation
//import UIKit
//import FirebaseCore
//import SdkPushExpress
//import UserNotifications
//
//class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
//
//    private let PUSHEXPRESS_APP_ID = "40326-1475"
//
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//        FirebaseApp.configure()
//        RemoteConfigManager.shared.fetchConfig()
//
//
//        UNUserNotificationCenter.current().delegate = self
//
//        do {
//            try PushExpressManager.shared.initialize(appId: PUSHEXPRESS_APP_ID, essentialsOnly: true)
//
//
//            PushExpressManager.shared.requestNotificationsPermission(registerForRemoteNotifications: true)
//
//            try PushExpressManager.shared.activate(extId: "")
//
//            print("PushExpress SDK Initialized and Activated successfully.")
//
//        } catch {
//            print("PushExpress SDK Error: \(error.localizedDescription)")
//        }
//
//        return true
//    }
//
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
//        let tokenString = tokenParts.joined()
//
//        print("Push Notifications: Device Token received: \(tokenString)")
//        PushExpressManager.shared.transportToken = tokenString
//    }
//
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print("Push Notifications: Failed to register for remote notifications: \(error.localizedDescription)")
//    }
//
//    // MARK: - UNUserNotificationCenterDelegate Methods
//
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//
//
//        print("==> Push Notification Received (Foreground):")
//        print("   Title: \(notification.request.content.title)")
//        print("   Body: \(notification.request.content.body)")
//        print("   UserInfo (Payload): \(notification.request.content.userInfo)")
//
//
//        if let imageURLString = notification.request.content.userInfo["image"] as? String,
//           let imageURL = URL(string: imageURLString) {
//            print("   Custom Image URL: \(imageURL)")
//
//        }
//        if let linkURLString = notification.request.content.userInfo["link"] as? String,
//           let linkURL = URL(string: linkURLString) {
//            print("   Custom Link URL: \(linkURL)")
//
//        }
//
//
//        completionHandler([.banner, .sound, .badge])
//    }
//
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//
//
//        print("==> Push Notification Tapped/Acted On:")
//        print("   Title: \(response.notification.request.content.title)")
//        print("   Body: \(response.notification.request.content.body)")
//        print("   UserInfo (Payload): \(response.notification.request.content.userInfo)")
//
//
//        if let linkURLString = response.notification.request.content.userInfo["link"] as? String,
//           let linkURL = URL(string: linkURLString) {
//
//            if UIApplication.shared.canOpenURL(linkURL) {
//                print("   Opening custom link: \(linkURL)")
//
//            }
//        }
//
//
//        completionHandler()
//    }
//}
