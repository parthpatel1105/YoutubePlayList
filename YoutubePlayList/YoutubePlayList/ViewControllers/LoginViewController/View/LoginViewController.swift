//  
//  LoginViewController.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 02/10/20.
//

import UIKit
import GoogleSignIn
class LoginViewController: UIViewController, Storyboarded {

    // MARK: - OUTLETS HERE

    // MARK: - VARIABLES HERE
    var viewModel = LoginViewControllerViewModel()

    
    // MARK: - ViewControl life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.scopes = ["https://www.googleapis.com/auth/youtube.readonly"]
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Login"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(userDidSignInGoogle(_:)), name: .signInGoogleCompleted, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK:- Notification
    @objc private func userDidSignInGoogle(_ notification: Notification) {
        // Update screen after user successfully signed in
        self.viewModel.startAuthentication()
    }
}

extension LoginViewController {
    @IBAction func SignInButtonTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }
}

extension LoginViewController {
    fileprivate func setupViewModel() {
        self.viewModel.viewController = self
        self.viewModel.showAlertClosure = {
            let alert = self.viewModel.alertMessage ?? ""
            print(alert)
        }
        
        self.viewModel.updateLoadingStatus = {
            if self.viewModel.isLoading {
                print("LOADING...")
            } else {
                 print("DATA READY")
            }
        }

        self.viewModel.internetConnectionStatus = {
            print("Internet disconnected")
            // show UI Internet is disconnected
        }

        self.viewModel.serverErrorStatus = {
            print("Server Error / Unknown Error")
            // show UI Server is Error
        }

        self.viewModel.didGetData = {
            // update UI after get data
        }

    }

}


//func loadVideosOfChannel() {
//
//    let accessToken = UserProfileData.youtubeAccessToken
//    let headers: HTTPHeaders = [
//        "Authorization": "Bearer \(accessToken)",
//        "Accept": "application/json"
//    ]
//    let urlReqStr = "https://www.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&mine=true&key=\(Localize(.youtubeAPIKey))"
//
//    AF.request(urlReqStr, method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON { response in
//        switch response.result {
//        case .failure(let error):
//            print("An error occured while fetch channel videos : \(String(describing: error.localizedDescription))")
//            return
//
//        case .success(_):
//            do{
//                let response = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments)
//                print("response is : \n : \(response)")
//
//                let responseDict1 = response as? [String : Any]
//                if let newdict = responseDict1!["error"] as? [String: Any]
//                {
//                    if newdict["code"] as? Int == 401
//                    {
//                        print("Authorization failed")
//                    }
//                    return
//                }
//
//                if let responseDict = response as? [String : Any],
//                    let channelItems = responseDict["items"] as? [[String: Any]]{
//
//                    var channelDetailDict = ["":""]
//
//                    let channelItem = channelItems[0]
//
//                    if let channelId = channelItem["id"] as? String{
//                        channelDetailDict["id"] = channelId
//                    }
//                    if let snippet = channelItem["snippet"] as? [String: Any]{
//                        channelDetailDict["name"] = (snippet["title"] as! String)
//                        channelDetailDict["publishedAt"] = (snippet["publishedAt"] as! String)
//
//                        debugPrint("Dscription : \((snippet["description"] as! String))")
//
//                        if let thumbnailsObj = snippet["thumbnails"] as? [String: Any],
//                            let defaultUrlStr = thumbnailsObj["default"] as? [String: Any]{
//                            channelDetailDict["url"] = (defaultUrlStr["url"] as! String)
//                        }
//                    }
//
//                }
//
//            }catch{
//                print("error occured while parse data : \(error.localizedDescription)")
//            }
//
//        }
//    }
//}
