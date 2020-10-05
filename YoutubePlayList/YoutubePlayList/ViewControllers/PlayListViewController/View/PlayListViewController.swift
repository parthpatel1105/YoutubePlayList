//  
//  PlayListViewController.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 03/10/20.
//

import UIKit

class PlayListViewController: UIViewController, Storyboarded {

    // OUTLETS HERE
    @IBOutlet var tableView: UITableView!
    
    // VARIABLES HERE
    var viewModel = PlayListViewControllerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupTableView()
        self.viewModel.handleGoogleLogin()
        self.viewModel.fetchPlayList()
        //self.tableView.register(cells: [PlayListTableViewCell.self])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = Localize(.myPlayListTitle)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupTableView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.cellIdentifier(identifier: String(describing: PlayListTableViewCell.self))
        self.tableView.setAutoRowHeight()
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension PlayListViewController: UITableViewDelegate, UITableViewDataSource {
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
        cell.configurePlayListCell(item: self.viewModel.playList?.items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = self.viewModel.playList?.items[indexPath.row]  {
            let itemViewController = ItemViewController.instantiateStoryboard(.VideoPlayList)
            itemViewController.viewModel.playList = item
            UserProfileData.selectedPlayListId = item.id
            self.navigationController?.pushViewController(itemViewController, animated: true)
        } else {
            presentAlertOnMainThread(title: "Play List Id is not Found", message: Localize(.alertTitle), buttonTitle: Localize(.OKTitle))
        }
        
    }
}

extension PlayListViewController {
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

