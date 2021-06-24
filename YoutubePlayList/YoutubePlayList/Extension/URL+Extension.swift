//
//  URL+Extension.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 04/01/21.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: StaticString) {
        self.init(string: "\(value)")!
    }
}

let stringURL = "www"
let request = URLRequest(url: "ppppppp")

extension URL {
    init(staticString: StaticString) {
        self.init(string: "\(staticString)")!
    }
}

let url = URL(staticString: "")
