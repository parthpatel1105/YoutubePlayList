//  
//  LoginViewControllerViewModel.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 02/10/20.
//

import Foundation
import GoogleSignIn

class LoginViewControllerViewModel {

    /// Count your data in model
    var count: Int = 0
    var viewController: UIViewController!

    /// Define boolean for internet status, call when network disconnected
    var isDisconnected: Bool = false {
        didSet {
            self.alertMessage = "No network connection. Please connect to the internet"
            self.internetConnectionStatus?()
        }
    }

    //MARK: -- UI Status

    /// Update the loading status, use HUD or Activity Indicator UI
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    /// Showing alert message, use UIAlertController or other Library
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    /// Define selected model
    //var selectedObject: LoginViewControllerModel?

    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?

    
    
    func startAuthentication() {
        guard NetMonitor.shared.netOn else {
            viewController.presentAlertOnMainThread(title: Localize(.alertTitle), message: Localize(.internetConnectionIssue), buttonTitle: Localize(.OKTitle))
            return
        }
        
        if let user = GIDSignIn.sharedInstance()?.currentUser {
            // User signed in
            UserProfileData.userProfileName = user.profile.givenName!
            UserProfileData.isUserLogin = true
            UserProfileData.userEmail = user.profile.email
            UserProfileData.userID = user.userID
            user.authentication.getTokensWithHandler { [weak self]  (auth, error) in
                guard let weakSelf = self else { return }
                guard error == nil else {
                    weakSelf.viewController.presentAlertOnMainThread(title: Localize(.alertTitle), message: error?.localizedDescription ?? Localize(.empty), buttonTitle: Localize(.OKTitle))
                  return
                }
                UserProfileData.youtubeAccessToken = auth!.accessToken
                print("Check User Login = \(UserProfileData.isUserLogin)")
                weakSelf.fetchChanelList()
                //Router.shared.checkUserLogin()
            }
        } else {
            // User signed out
        }
    }
    
    //MARK: -- Fetch Channel
    
    func fetchChanelList() {
        guard NetMonitor.shared.netOn else {
            viewController.presentAlertOnMainThread(title: Localize(.alertTitle), message: Localize(.internetConnectionIssue), buttonTitle: Localize(.OKTitle))
            return
        }
        
        viewController.showLoadingView()
       
        APIManager.shared.youtubePlayListAPI(request: APIEndpoint.getYoutubeChannel.getURLRequest()) { [weak self] (result: Result<[String: Any], ErrorMessage>) in
            guard let weakSelf = self else { return }
            weakSelf.viewController.dismissLoadingView()
            switch result {
                case .success(let response):
                    print(response)
                    if let channelItems = response["items"] as? [[String: Any]] {
                        let channelItem = channelItems[0]
                        if let channelId = channelItem["id"] as? String{
                            UserProfileData.youtubeChannelId = channelId
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                Router.shared.checkUserLogin()
            }
            
        }
    }



    //MARK: -- Example Func
    /*
    func exampleBind() {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            // call your service here
            self.service.removeThisFuncName(success: { data in
                
                self.isLoading = false
                // self.model = data
                self.didGetData?()
                
            }) { errorMsg, errorCode in
                if errorCode == 0 {
                    self.serverErrorStatus?()
                } else {
                    self.isLoading = false
                    self.alertMessage = errorMsg
                }
            }
        default:
            break
        }
    }
    */

}

extension LoginViewControllerViewModel {

}
