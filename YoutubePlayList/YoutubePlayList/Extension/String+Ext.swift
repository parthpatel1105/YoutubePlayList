//
//  String+Ext.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 05/10/20.
//

import UIKit

extension String {

func getYoutubeFormattedDuration() -> String {

    let formattedDuration = self.replacingOccurrences(of: "PT", with: "").replacingOccurrences(of: "H", with:":").replacingOccurrences(of: "M", with: ":").replacingOccurrences(of: "S", with: "")

    let components = formattedDuration.components(separatedBy: ":")
    var duration = ""
    if components.count == 1 {
        return "00:\(components[0])"
    }
    for component in components {
        duration = duration.count > 0 ? duration + ":" : duration
        if component.count < 2 {
            duration += "0" + component
            continue
        }
        duration += component
    }
    return duration

}

}
