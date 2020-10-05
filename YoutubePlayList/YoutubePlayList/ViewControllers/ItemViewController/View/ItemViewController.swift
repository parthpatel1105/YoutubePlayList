//  
//  ItemViewController.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 04/10/20.
//

import UIKit
import SafariServices

class ItemViewController: UIViewController, Storyboarded, SFSafariViewControllerDelegate {

    // OUTLETS HERE
    @IBOutlet var tableView: UITableView!
    
    // VARIABLES HERE
    var viewModel = ItemViewControllerViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupTableView()
        self.viewModel.fetchItemList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        //self.title = self.viewModel.playList?.snippet.title
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupTableView() {
        

        self.tableView.cellIdentifier(identifier: String(describing: PlayListTableViewCell.self))
        self.tableView.setAutoRowHeight()
        self.tableView.tableFooterView = UIView(frame: .zero)
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: Localize(.empty), style: .plain, target: nil, action: nil)
        
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.tableView.tableHeaderView = ItemHeaderView(item: self.viewModel.playList).view


    }

    
}

extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayListTableViewCell.reuseIdentifier, for: indexPath) as? PlayListTableViewCell else {
            fatalError("Unable to Dequeue PlayList Table View Cell")
        }
        cell.selectionStyle = .none
            
        cell.configureItemListCell(item: self.viewModel.itemList?.items[indexPath.row], videoInfo: self.viewModel.videoDetails)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = self.viewModel.itemList?.items[indexPath.row].contentDetails.videoID  {
            let videoStr = Localize(.playVideoURL) + id
            print(videoStr)
            let safariVC = SFSafariViewController(url: URL(string: videoStr)!)
            safariVC.delegate = self
            self.present(safariVC, animated: true, completion: nil)
        }
        

    }
}


extension ItemViewController {
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

        self.viewModel.didGetData = { [weak self] in
            guard let weakSelf = self else { return }
            //weakS1elf.tableView.reloadData()
            DispatchQueue.main.async {
                weakSelf.tableView.reloadData()
            }
        }

    }
}


