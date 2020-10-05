//
//  ReusableViews.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 04/10/20.
//

import UIKit


protocol ReusableView {
    static var reuseIdentifier: String { get }
    func separator(hide: Bool)
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {
    func separator(hide: Bool) {
      separatorInset.left = hide ? bounds.size.width : 0
    }
}

extension UITableView {
    func cellIdentifier(identifier: String) {
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }

    func cellIdentifierWithValue(identifier: String, identifierValue: String) {
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifierValue)
    }

    func setAutoRowHeight(estimated: CGFloat = 70) {
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = estimated
    }
}
