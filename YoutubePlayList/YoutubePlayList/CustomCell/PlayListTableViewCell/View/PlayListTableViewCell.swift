//  
//  PlayListTableViewCell.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 04/10/20.
//

import UIKit

class PlayListTableViewCell: UITableViewCell {

    // OUTLETS HERE

    @IBOutlet var thumbImageView: LazyImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    // VARIABLES HERE
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
        self.setupLayout()
    }
    
    func setupLayout() {
        self.accessoryType = .disclosureIndicator
    }
    
    func configurePlayListCell(item: Item?) {
        self.titleLabel.text = item?.snippet.title
        if let imageURL = item?.snippet.thumbnails.medium.url {
            self.thumbImageView.loadImage(fromURL: URL(string: imageURL)!, placeHolderImage: "LaunchImage")
        }
        if let channelTitle = item?.snippet.channelTitle, let itemCount = item?.contentDetails.itemCount {
            self.subTitleLabel.text = channelTitle + Localize(.emptySpace) + "⋆" + "\(itemCount)" + Localize(.emptySpace) + (itemCount <= 1 ? Localize(.song) : Localize(.songs))
        }
        
    }
    
    func configureItemListCell(item: PlayListItem?, videoInfo: [VideoInfo]) {
        var convertedDuration = Localize(.empty)
        if let itemId = item?.contentDetails.videoID {
            print("itemId = \(itemId)")
            let itemArray1 = videoInfo.map{$0.items.map{$0.id}.map{$0}}
            print(itemArray1)
            if let videoIndex = itemArray1.flatMap({$0}).firstIndex(of: itemId) {
                print("videoIndex = \(videoIndex)")
                if !videoInfo[videoIndex].items.isEmpty {
                    let youtubeVideoDurationString = videoInfo[videoIndex].items[0].contentDetails.duration
                    print("Duration = \(youtubeVideoDurationString)")
                    convertedDuration = youtubeVideoDurationString.getYoutubeFormattedDuration() //returns 02:24
                    print("convertedDuration = \(convertedDuration)")
                }
                
            }
        }
        
        self.titleLabel.text = item?.snippet.title
        if let imageURL = item?.snippet.thumbnails.medium.url {
            self.thumbImageView.loadImage(fromURL: URL(string: imageURL)!, placeHolderImage: "LaunchImage")
        }
        if let channelTitle = item?.snippet.channelTitle {
            if convertedDuration.count > 0 {
                self.subTitleLabel.text = channelTitle + Localize(.emptySpace) + "⋆ \(convertedDuration)"
            } else {
                self.subTitleLabel.text = channelTitle
            }
            
        }
        
    }

    
}


/*
 let array = videoInfo.filter ({$0.items.map({$0.id})})
 print(videoInfo)

 //        videoInfo.map ({$0.items}).map{($0.id)}
 //        videoInfo.first(where: {$0.items == item1})
 //        videoInfo.map ({$0.items}).first(where: {$0.})
 //        videoInfo.firstIndex(where: ({$0.items.map({$0.id})[1] == "RjfmJNs2sFY"}))
 //        videoInfo.filter ({
 //            $0.items.map{($0.id)}.firsIndex(where: ({$0 == ""}))
 //        })
 //        videoInfo.filter ({ $0.items.map ({ $0.id }) == "" })
 //        videoInfo.filter {$0.items.contains(where: "sds")}
 //        let ff = videoInfo[1].items
 //        let gg = ff.filter({$0.id == "RjfmJNs2sFY"})
 //        let ff1 = videoInfo.map {($0.items)}
 //        //let gg1 = ff1.filter({$0.})
 //        let itemArray = videoInfo.map{$0.items.map{$0.id}}
 //        print(itemArray)
 //        videoInfo.map{$0.items.map{$0.id}.map{$0}}.flatMap {$0}.firstIndex(of: "PbW1UbPHRkA")
 //        po itemArray1.flatMap {$0}.firstIndex(of: "PbW1UbPHRkA")
 //        po (videoInfo.map{$0.items.map{$0.id}.map{$0}}).flatMap {$0}.firstIndex(of: "PbW1UbPHRkA")
 //        po videoInfo.map({$0.etag}).firstIndex(of: "e3ImL5u8xmDItIVp2yGELm4Fmak")
 //        po videoInfo.map({$0.items.map{$0.id}}).firstIndex(of: "e3ImL5u8xmDItIVp2yGELm4Fmak")
         //let array1 = videoInfo.filter ({$0.items.map{$0.id}} == "")
 //        let array = videoInfo.map {$0.items.map{$0.id}}
 //        print(array)
         //item?.contentDetails.videoID

 */
 
