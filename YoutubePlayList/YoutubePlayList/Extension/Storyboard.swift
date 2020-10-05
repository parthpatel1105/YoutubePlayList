//
//  Storyboard.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 02/10/20.
//

import Foundation
import UIKit

enum Storyboard: String {
    case LoginView
    case VideoPlayList
}

protocol Storyboarded {
    static func instantiateStoryboard(_ type: Storyboard) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiateStoryboard(_ type: Storyboard) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: type.rawValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
