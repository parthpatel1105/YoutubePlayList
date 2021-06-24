//
//  weakify.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 04/03/21.
//

import UIKit

class Service {
    func call(with completion: @escaping (Int) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(42)
        }
    }
}

class ViewController: UIViewController {
    
    let service = Service()
    let label = UILabel()
    
    func format(data: Int) -> String {
        return "\(data)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Retrieved data: "
        
        service.call(with: weakify { strongSelf, data in
            /* Specific logic */
            let formatted = strongSelf.format(data: data)
            strongSelf.label.text?.append(formatted)
            /* End of specific logic */
        })
    }
}

protocol Weakifiable: class { }

extension NSObject: Weakifiable { }

extension Weakifiable {
    func weakify<T>(_ code: @escaping (Self, T) -> Void) -> (T) -> Void {
        return {
            /* Begin boilerplate */
            [weak self] (data) in
            
            guard let self = self else { return }
            /* End boilerplate */
            
            code(self, data)
        }
    }
}
