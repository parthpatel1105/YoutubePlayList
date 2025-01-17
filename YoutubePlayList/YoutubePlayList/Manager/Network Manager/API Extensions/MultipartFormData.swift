//
//  MultipartFormData.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 02/10/20.
//

import Foundation

/// Represents "multipart/form-data" for an upload.
public struct MultipartFormData {

    public init(data: Data, name: String, fileName: String? = nil, mimeType: String? = nil) {
        self.data = data
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }

    /// The method being used for providing form data.
    public let data: Data

    /// The name.
    public let name: String

    /// The file name.
    public let fileName: String?

    /// The MIME type
    public let mimeType: String?

}

