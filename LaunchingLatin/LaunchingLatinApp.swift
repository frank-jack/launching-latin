//
//  LaunchingLatinApp.swift
//  LaunchingLatin
//
//  Created by Jack Frank on 6/13/22.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin
/*import Firebase
import FirebaseMessaging
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {success, _ in
            guard success else {
                return
            }
            print("Success in APNS registry")
        }
      
        application.registerForRemoteNotifications()

        return true
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            print("Token: \(token)")
        }
    }
}*/


@main
struct LaunchingLatinApp: App {
    //@UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var sessionManager = SessionManager()
    init() {
        configureAmplify()
        sessionManager.getCurrentAuthUser()
    }
    @StateObject private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}

private func configureAmplify() {
    do {
        try Amplify.add(plugin: AWSCognitoAuthPlugin())
        try Amplify.configure()
        print("Amplify configured successfully")
        
    } catch {
        print("could not initialize Amplify", error)
    }
}
