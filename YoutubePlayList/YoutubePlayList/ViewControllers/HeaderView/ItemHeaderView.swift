//
//  ItemHeaderView.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 04/10/20.
//

import UIKit

class ItemHeaderView: UIViewController {
    @IBOutlet var itemImageView: LazyImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!

    let item: Item
    
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
    }
    
    func configureUIElements() {
        self.itemImageView.loadImage(fromURL: URL(string: item.snippet.thumbnails.medium.url)!, placeHolderImage: "LaunchImage")
        titleLabel.text = item.snippet.title
        let itemCount = item.contentDetails.itemCount
        detailLabel.text = item.snippet.channelTitle + Localize(.coloumnSpace) + "\(itemCount)" + Localize(.emptySpace) + (itemCount <= 1 ? Localize(.song) : Localize(.songs))
    }
}
