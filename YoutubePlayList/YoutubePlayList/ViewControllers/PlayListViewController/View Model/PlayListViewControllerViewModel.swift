//  
//  PlayListViewControllerViewModel.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 03/10/20.
//

import Foundation
import UIKit
import GoogleSignIn

class PlayListViewControllerViewModel {

    /// Count your data in model
    var count: Int = 0
    var viewController: UIViewController!
    var playList: PlayList?
    //MARK: -- Network checking


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
    //var selectedObject: ChanelListViewControllerModel?

    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?

    init() {
    }

    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return self.playList?.items.count ?? 0
    }
    
    func handleGoogleLogin() {
        if GIDSignIn.sharedInstance().hasPreviousSignIn() {
            GIDSignIn.sharedInstance().restorePreviousSignIn()
            if GIDSignIn.sharedInstance().currentUser == nil {
                    
            } else {
                GIDSignIn.sharedInstance().currentUser?.authentication.getTokensWithHandler { (auth, error) in
                    if error == nil{
                        UserProfileData.youtubeAccessToken = auth!.accessToken
                    }else{
                        debugPrint("Error while getTokensWithHandler : \(error?.localizedDescription ?? "")")
                    }
                }
            }
        } else {
            
        }
    }

    //MARK: -- Fetch PlayList
    
    func fetchPlayList() {
        guard NetMonitor.shared.netOn else {
            viewController.presentAlertOnMainThread(title: Localize(.alertTitle), message: Localize(.internetConnectionIssue), buttonTitle: Localize(.OKTitle))
            return
        }
        
        viewController.showLoadingView()
        APIManager.shared.youtubeAPIFetch(request: APIEndpoint.getYoutubePlayList.getURLRequest()) { [weak self] (result: Result<PlayList, ErrorMessage>) in
            guard let weakSelf = self else { return }
            weakSelf.viewController.dismissLoadingView()
            switch result {
                case .success(let response):
                    weakSelf.playList = response
                    weakSelf.didGetData?()
                case .failure(let error):
                    if error.localizedDescription == "The operation couldn’t be completed" {
                        UserProfileData.isUserLogin = false
                        Router.shared.checkUserLogin()
                    }
                    print(error.localizedDescription)
            }

        }
        
        
//        APIManager.shared.youtubePlayListAPI(request: APIEndpoint.getYoutubePlayList.getURLRequest()) { [weak self] (result: Result<PlayList, ErrorMessage>) in
//            guard let weakSelf = self else { return }
//            weakSelf.viewController.dismissLoadingView()
//            switch result {
//                case .success(let response):
//                    print(response)
//
//
//                case .failure(let error):
//                    print(error.localizedDescription)
//            }
//        }
    }
}

extension PlayListViewControllerViewModel {

}
