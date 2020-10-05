//
//  AppDelegate.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 02/10/20.
//

import GoogleSignIn
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Internet connection monitoring starts
        NetMonitor.shared.startMonitoring()
        // Setup Google Credentials
        self.setupGoogleLogin()
        Router.shared.checkUserLogin()
        return true
    }
    
    private func setupGoogleLogin() {
        GIDSignIn.sharedInstance().clientID = Localize(.googleClientId)
         GIDSignIn.sharedInstance()?.scopes = ["https://www.googleapis.com/auth/youtube.force-ssl", "https://www.googleapis.com/auth/youtube"]
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
}

extension AppDelegate {
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
}

extension AppDelegate: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
                UserProfileData.isUserLogin = false
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }

        // Post notification after user successfully sign in
        NotificationCenter.default.post(name: .signInGoogleCompleted, object: nil)
    }
}

// MARK: - Notification names

extension Notification.Name {
    /// Notification when user successfully sign in using Google
    static var signInGoogleCompleted: Notification.Name {
        return .init(rawValue: #function)
    }
}

// client Id - 918527852880-jepiitt2dcgd2d9t3hgts3q8uj6lihfc.apps.googleusercontent.com
// iOS URL scheme - com.googleusercontent.apps.918527852880-jepiitt2dcgd2d9t3hgts3q8uj6lihfc
// api key - AIzaSyBqm7Ho9oso95md9tkPmMBH7XF21fdxwtE
// com.parth.test.YoutubePlayList
// com.bluurp.app
// com.googleusercontent.apps.536256005559-3jdbfka8krelha9hli99nspe3mniaei7
// bluurp - AIzaSyDhCXvoaWpPpMdcHrhLzEsKUfOUSTF8xzc
// com.googleusercontent.apps.536256005559-3jdbfka8krelha9hli99nspe3mniaei7
// 536256005559-3jdbfka8krelha9hli99nspe3mniaei7.apps.googleusercontent.com
