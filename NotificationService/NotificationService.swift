//
//  NotificationService.swift
//  NotificationService
//
//

import UserNotifications
import SdkPushExpress

class NotificationService: UNNotificationServiceExtension {

 var contentHandler: ((UNNotificationContent) -> Void)?
 var bestAttemptContent: UNMutableNotificationContent?
 let notificationServiceManager = NotificationManager()

 override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
     self.contentHandler = contentHandler
     if let bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent){
        print("bestAttemptContent: \(bestAttemptContent)")
     } else {
        print("Failed to create bestAttemptContent")
     }
     notificationServiceManager.handleNotification(request: request, contentHandler: contentHandler)
 }

 override func serviceExtensionTimeWillExpire() {
     // Called just before the extension will be terminated by the system.
     // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
     if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
         contentHandler(bestAttemptContent)
     }
 }

}
