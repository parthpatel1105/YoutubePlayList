//  
//  PlayListTableViewCellViewModel.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 04/10/20.
//

import Foundation

class PlayListTableViewCellViewModel {

    /// Count your data in model
    var count: Int = 0

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
    //var selectedObject: PlayListTableViewCellModel?

    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?

}

extension PlayListTableViewCellViewModel {

}
