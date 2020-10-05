//
//  ItemViewControllerViewModel.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 04/10/20.
//

import Foundation
import UIKit

class ItemViewControllerViewModel {
    /// Count your data in model
    var count: Int = 0
    var viewController: UIViewController!
    var itemList: ItemList?
    var playList: Item!
    var videoIds: [String]?
    var videoDetails = [VideoInfo]()
    // MARK: - - Network checking

    /// Define boolean for internet status, call when network disconnected
    var isDisconnected: Bool = false {
        didSet {
            self.alertMessage = "No network connection. Please connect to the internet"
            self.internetConnectionStatus?()
        }
    }

    // MARK: - - UI Status

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
    // var selectedObject: ItemViewControllerModel?

    // MARK: - - Closure Collection

    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows() -> Int {
        return self.itemList?.items.count ?? 0
    }

    // MARK: - - Fetch ItemList

    func fetchItemList() {
        guard NetMonitor.shared.netOn else {
            self.viewController.presentAlertOnMainThread(title: Localize(.alertTitle), message: Localize(.internetConnectionIssue), buttonTitle: Localize(.OKTitle))
            return
        }

        self.viewController.showLoadingView()
        APIManager.shared.youtubeAPIFetch(request: APIEndpoint.getYoutubeItemList.getURLRequest()) { [weak self] (result: Result<ItemList, ErrorMessage>) in
            guard let weakSelf = self else { return }
            weakSelf.viewController.dismissLoadingView()
            switch result {
                case .success(let response):
                    weakSelf.itemList = response
                    if let item = weakSelf.itemList?.items {
                        weakSelf.videoIds = item.map {$0.contentDetails.videoID }
                        print("weakSelf.videoIds! = \(weakSelf.videoIds!)")
                        DispatchQueue.main.async {
                            weakSelf.getVideoDetail()
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func getVideoDetail() {
        let group = DispatchGroup()
        self.viewController.showLoadingView()
        // We need to dispatch to a background queue because we have
        // to wait for the response from the webservice
        DispatchQueue.global(qos: .utility).async {
            for item in self.videoIds! {
                group.enter()          // signal that you are starting a new task
                APIManager.shared.youtubeAPIFetch(request: APIEndpoint.getYoutubeVideoInfo.createURLRequest(videoId: item)) { [weak self] (result: Result<VideoInfo, ErrorMessage>) in
                    guard let weakSelf = self else { return }
                    
                    switch result {
                        case .success(let response):
                            //print(response)
                            weakSelf.videoDetails.append(response)
                            //weakSelf.didGetData?()
                        case .failure(let error):
                            print(error.localizedDescription)
                    }
                    group.leave()
                    print("Leave group")

                }
            }

            group.wait()               // don't ever call wait() on the main queue
            print("Finish request")
            self.viewController.dismissLoadingView()
            self.didGetData?()
            // Now all requests are complete
        }
    }
}

extension ItemViewControllerViewModel {}
