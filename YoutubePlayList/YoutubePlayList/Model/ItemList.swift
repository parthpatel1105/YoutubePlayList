//
//  ItemList.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 03/10/20.
//

import Foundation


// MARK: - Welcome
struct ItemList: Codable {
    let kind, etag: String
    let items: [PlayListItem]
    let pageInfo: PageInfoItem
}

// MARK: - Item
struct PlayListItem: Codable {
    let kind, etag, id: String
    let snippet: SnippetItem
    let contentDetails: ContentDetailsItem
    let status: StatusItem
}

// MARK: - ContentDetails
struct ContentDetailsItem: Codable {
    let videoID: String
    let videoPublishedAt: String

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case videoPublishedAt
    }
}

// MARK: - Snippet
struct SnippetItem: Codable {
    let publishedAt: String
    let channelID, title, snippetDescription: String
    let thumbnails: ThumbnailsItem
    let channelTitle, playlistID: String
    let position: Int
    let resourceID: ResourceIDItem

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle
        case playlistID = "playlistId"
        case position
        case resourceID = "resourceId"
    }
}

// MARK: - ResourceID
struct ResourceIDItem: Codable {
    let kind, videoID: String

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

// MARK: - Thumbnails
struct ThumbnailsItem: Codable {
    let thumbnailsDefault, medium, high: DefaultItem
    let standard: DefaultItem?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard
    }
}

// MARK: - Default
struct DefaultItem: Codable {
    let url: String
    let width, height: Int
}

// MARK: - Status
struct StatusItem: Codable {
    let privacyStatus: String
}

// MARK: - PageInfo
struct PageInfoItem: Codable {
    let totalResults, resultsPerPage: Int
}
