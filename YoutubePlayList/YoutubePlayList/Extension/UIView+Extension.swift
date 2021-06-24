//
//  UIView+Extension.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 28/01/21.
//

import UIKit

let view = UIView()


//UIView.animate(withDuration: 0.3) {
//    view.backgroundColor = .orange
//}

extension UIView {
    static func animate(withDuration: TimeInterval, _ animations: @escaping @autoclosure () -> Void) {
        UIView.animate(withDuration: withDuration, animations: animations)
    }
}

//UIView.animate(withDuration: 0.3, view.backgroundColor = .orange)
