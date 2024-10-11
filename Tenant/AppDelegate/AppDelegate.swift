//
//  AppDelegate.swift
//  Tenant
//
//  Created by MacBook Pro on 6/10/24.
//

import UIKit
import GoogleMaps
import IQKeyboardManager
import NMAKit
import Photos
import PhotosUI
import UserNotifications
import Firebase
import FirebaseMessaging
import FirebaseCore
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var notificationUserInfo: [AnyHashable: Any]?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        registerForPushNotifications()
        UNUserNotificationCenter.current().delegate = self
        
        requestPhotoLibraryPermission()
        
        NMAApplicationContext.set(appId: Constants.hereAppID, appCode: Constants.apiKey)
        GMSServices.provideAPIKey("AIzaSyBC2Xdb2ato7ULwuGnDjPLXLAvqUZx_1VM")
        let language: AppLanguage = AppLanguage(rawValue: UserDefaults.standard.selectedLanguage ?? "") ?? .english
        UIView.appearance().semanticContentAttribute = Helper.shared.semantic(language)
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        return true
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Permission for push notifications denied.")
            }
        }
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
    
    func requestPhotoLibraryPermission() {
        PHPhotoLibrary.requestAuthorization { _ in
            
        }
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        UserDefaults.standard.deviceToken = fcmToken
    }
}

// MARK: - UNUserNotificationCenter Delegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    // Handle notification display when the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge, .list])
    }
    
    // Handle notification interaction
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("User Info: \(userInfo)")
        
        // Store the userInfo in the property
        self.notificationUserInfo = userInfo
        
        if let complaintID = userInfo["complaint_id"] as? String {
            // Check if the app is ready to process the request
            DispatchQueue.main.async {
                if UIApplication.shared.applicationState == .active {
                    // App is in the foreground, process the notification immediately
                    self.navigateToView(complaintID: Int(complaintID) ?? 0)
                } else {
                    // App is in the background or launching from a closed state
                    // Wait for the app to become active
                    NotificationCenter.default.addObserver(self, selector: #selector(self.handleAppForeground(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
                }
            }
        }
        completionHandler()
    }

    @objc func handleAppForeground(_ notification: Notification) {
        // Ensure the app has fully entered the foreground
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        
        // Use the stored notificationUserInfo to process the notification
        if let userInfo = self.notificationUserInfo,
           let complaintID = userInfo["complaint_id"] as? String {
            self.navigateToView(complaintID: Int(complaintID) ?? 0)
        }
    }


    func navigateToView(complaintID: Int) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first else {
            print("Unable to get key window")
            return
        }
        
        switch UserDefaults.standard.userType {
        case UserType.tenant.rawValue:
            let vc: TenantCompletedViewController = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TenantCompletedViewController") as! TenantCompletedViewController
            vc.complaintID = complaintID
            vc.isNotificationTapped = true
            let nav = UINavigationController(rootViewController: vc)
            keyWindow.rootViewController = nav
            keyWindow.makeKeyAndVisible()
            
        case UserType.owner.rawValue:
            if let window = UIApplication.shared.windows.first {
                let vc: OwnerDetailViewController = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "OwnerDetailViewController") as! OwnerDetailViewController
                vc.complaintID = complaintID
                vc.isNotificationTapped = true
                let nav = UINavigationController(rootViewController: vc)
                window.rootViewController = nav
                window.makeKeyAndVisible()
            }
            
        case UserType.company.rawValue:
            if let window = UIApplication.shared.windows.first {
                let vc: CompanyPendingController = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyPendingController") as! CompanyPendingController
                vc.complaintID = complaintID
                vc.isNotificationTapped = true
                let nav = UINavigationController(rootViewController: vc)
                window.rootViewController = nav
                window.makeKeyAndVisible()
            }
        case UserType.worker.rawValue:
            print("")
            let vc: WorkerOngoingDetailViewController = UIStoryboard(name: Storyboard.worker.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WorkerOngoingDetailViewController") as! WorkerOngoingDetailViewController
            vc.complaintID = complaintID
            vc.isNotificationTapped = true
            let nav = UINavigationController(rootViewController: vc)
            keyWindow.rootViewController = nav
            keyWindow.makeKeyAndVisible()
        default:
            print("")
        }
    }
    
    //
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    //
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error)")
    }
}
