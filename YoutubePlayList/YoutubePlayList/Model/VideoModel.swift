//
//  VideoModel.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 04/10/20.
//

import Foundation

// MARK: - Welcome
struct VideoInfo: Codable {
    let kind, etag: String
    let items: [VideoItem]
    let pageInfo: VideoPageInfo
}

// MARK: - Item
struct VideoItem: Codable {
    let kind, etag, id: String
    let contentDetails: VideoContentDetails
}

// MARK: - ContentDetails
struct VideoContentDetails: Codable {
    let duration, dimension, definition, caption: String
    let licensedContent: Bool
    let contentRating: ContentRating
    let projection: String
}

// MARK: - ContentRating
struct ContentRating: Codable {
}

// MARK: - PageInfo
struct VideoPageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
