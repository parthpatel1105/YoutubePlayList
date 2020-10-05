//  
//  ItemViewControllerView.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 04/10/20.
//

import UIKit

class ItemViewController: UIViewController, Storyboarded {

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
        self.title = Localize(.myPlayListTitle)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupTableView() {
        self.tableView.cellIdentifier(identifier: String(describing: PlayListTableViewCell.self))
        self.tableView.setAutoRowHeight()
        self.tableView.tableFooterView = UIView(frame: .zero)
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
        //`cell.configureCell(item: self.viewModel.itemList?.items[indexPath.row])
        return cell
    }
}


extension ItemViewController {
    fileprivate func setupViewModel() {

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


