//
//  CopyDeck.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 02/10/20.
//

enum CopyDeck: String {
//    case googleClientId = "918527852880-jepiitt2dcgd2d9t3hgts3q8uj6lihfc.apps.googleusercontent.com"
//    case youtubeAPIKey = "AIzaSyBqm7Ho9oso95md9tkPmMBH7XF21fdxwtE"
    case googleClientId = "536256005559-3jdbfka8krelha9hli99nspe3mniaei7.apps.googleusercontent.com"
    case youtubeAPIKey = "AIzaSyDhCXvoaWpPpMdcHrhLzEsKUfOUSTF8xzc"
    case alertTitle = "Alert"
    case internetConnectionIssue = "Check your internet connection"
    case OKTitle = "OK"
    case userProfileName = "userProfileName"
    case userID = "userID"
    case userEmail = "userEmail"
    case isUserLogin = "isUserLogin"
    case empty = ""
    case coloumnSpace = ": "
    case emptySpace = " "
    case songs = "songs"
    case song = "song"
    case youtubeAccessToken = "youtubeAccessToken"
    case youtubeChannelId = "youtubeChannelId"
    case channelId = "UCH7xB2pfOwoZFCgNNlEgZEQ"
    case myPlayListTitle = "My PlayList"
    case selectedPlayListId = "selectedPlayListId"
    case playVideoURL = "https://www.youtube.com/embed/"
    case baseURL = "https://www.googleapis.com/youtube/v3/"

    //case playListPath = "playlists?part=snippet%2CcontentDetails%2Cid%2Cplayer%2Cstatus&maxResults=20&channelId=UCH7xB2pfOwoZFCgNNlEgZEQ&key="
    case playListPath = "playlists?part=snippet,contentDetails,id,player,status&maxResults=20"
    case itemListPath = "playlistItems?part=snippet,contentDetails,id,status&maxResults=20"
    case videoInfoPath = "videos?part=contentDetails"

//    case playListPath = "playlists?part=snippet%2CcontentDetails%2Cid%2Clocalizations%2Cplayer%2Cstatus&channelId=UCH7xB2pfOwoZFCgNNlEgZEQ&key="
    
    
    
    case channelPath = "channels?part=snippet%2CcontentDetails%2Cstatistics&mine=true&key="
    
    //    case baseURL = "https://www.googleapis.com/youtube/v3/playlists?part=snippet%2CcontentDetails%2Cid%2Clocalizations%2Cplayer%2Cstatus&channelId=UCH7xB2pfOwoZFCgNNlEgZEQ&key="
    
//    case baseURL = "https://www.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&mine=true&key="
}
