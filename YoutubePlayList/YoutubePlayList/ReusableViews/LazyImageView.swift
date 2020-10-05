//
//  LazyImageView.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 04/10/20.
//

import Foundation
import UIKit

class LazyImageView: UIImageView
{
    private let imageCache = NSCache<NSString, UIImage>()

    func loadImage(fromURL imageURL: URL, placeHolderImage: String)
    {
        self.image = UIImage(named: placeHolderImage)
        let cacheKey = NSString(string: imageURL.absoluteString)
        
        if let cachedImage = self.imageCache.object(forKey: cacheKey)
        {
            //debugPrint("image loaded from cache for =\(imageURL)")
            self.image = cachedImage
            return
        }

        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if let imageData = try? Data(contentsOf: imageURL)
            {
                //debugPrint("image downloaded from server...")
                if let image = UIImage(data: imageData)
                {
                    DispatchQueue.main.async {
                        self.imageCache.setObject(image, forKey: cacheKey)
                        self.image = image
                    }
                }
            }
        }
    }
}

