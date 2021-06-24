//
//  Optional+Extension.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 04/01/21.
//

import Foundation


extension Optional where Wrapped == String {
    var orEmpty: String {
        switch self {
        case .some(let value):
            return value
        case .none:
            return ""        
        }
    }
}
