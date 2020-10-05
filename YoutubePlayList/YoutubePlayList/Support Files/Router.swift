//
//  Router.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 03/10/20.
//

import Foundation
import UIKit
import GoogleSignIn

class Router {
    static public let shared = Router()
    
    func checkUserLogin() {
        print("Check User Login = \(UserProfileData.isUserLogin)")
        if !UserProfileData.isUserLogin {
            // Open Google Login screen
            let loginView = LoginViewController.instantiateStoryboard(.LoginView)
            UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: loginView)
        } else {
            // User is already login with Google
            let playListView = PlayListViewController.instantiateStoryboard(.VideoPlayList)
            UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: playListView)


        }
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

}
