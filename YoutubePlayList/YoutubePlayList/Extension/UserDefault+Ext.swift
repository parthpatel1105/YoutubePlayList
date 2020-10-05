//
//  Userdefault+Ext.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 02/10/20.
//

import Foundation

@propertyWrapper
struct Storage<T> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}


// The UserDefaults wrapper
struct UserProfileData {
    @Storage(key: Localize(.userProfileName), defaultValue: Localize(.empty))
    static var userProfileName: String
    
    @Storage(key: Localize(.userID), defaultValue: Localize(.empty))
    static var userID: String
    
    @Storage(key: Localize(.userEmail), defaultValue: Localize(.empty))
    static var userEmail: String

    @Storage(key: Localize(.youtubeAccessToken), defaultValue: Localize(.empty))
    static var youtubeAccessToken: String
    
    @Storage(key: Localize(.isUserLogin), defaultValue: false)
    static var isUserLogin: Bool
    
    @Storage(key: Localize(.youtubeChannelId), defaultValue: Localize(.channelId))
    static var youtubeChannelId: String

    @Storage(key: Localize(.selectedPlayListId), defaultValue: Localize(.empty))
    static var selectedPlayListId: String

}
