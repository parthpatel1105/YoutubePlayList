//
//  Sequence+Extension.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 03/03/21.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(by path: KeyPath<Element, T>) -> [Element] {
        return self.sorted { (a,b) -> Bool in
            return a[keyPath: path] < b[keyPath: path]
        }
    }
    
    func sorted<T: Comparable>(by path: KeyPath<Element, T?>,
                               default defaultValue: @autoclosure () -> T) -> [Element] {
        return self.sorted { (a,b) -> Bool in
            return (a[keyPath: path] ?? defaultValue()) < (b[keyPath: path] ?? defaultValue())
        }
    }
}

struct Person {
    var givenName: String
    var familyName: String
}

class Test {
    init() {
        let people: [Person] = []
        let sortedPeople = people.sorted(by: \.familyName)
    }
    
}
