//
//  Array+Extension.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 04/01/21.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
