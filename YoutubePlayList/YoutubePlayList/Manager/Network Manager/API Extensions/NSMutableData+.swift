//
//  NSMutableData+.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 02/10/20.
//

import Foundation

extension NSMutableData {
  public func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
