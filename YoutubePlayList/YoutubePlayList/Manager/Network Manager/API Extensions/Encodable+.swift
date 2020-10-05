//
//  Encodable+.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 02/10/20.
//

import Foundation

extension Encodable {
    public func toJSONData()throws -> Data { try JSONEncoder().encode(self) }
    public func toJSONData(_ encoder: JSONEncoder) throws -> Data {try encoder.encode(self)}
}
