//
//  LogFiles.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 04/01/21.
//

import Foundation

open class Logger {
    public class func log(_ message: String,
             _ file: String = #file,
             _ line: Int =  #line,
             _ function: String = #function) {
        #if DEBUG
            print("[\(file):\(line)] \(function) - \(message)")
        #endif
    }

    func foo() {
        Logger.log("Hello World")
    }

}
