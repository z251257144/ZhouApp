//
//  BaseLog.swift
//  Alamofire
//
//  Created by ZhouMin on 2019/8/21.
//

import Foundation

/**
 See: https://gist.githubusercontent.com/Abizern/a81f31a75e1ad98ff80d/raw/85b85cbb9bcdeb8cdbf2521ac935e3d2cb4cdd4f/loggingPrint.swift
 
 Prints the filename, function name, line number and textual representation of `object` and a newline character into
 the standard output if the build setting for "Other Swift Flags" defines `-D DEBUG`.
 
 The current thread is a prefix on the output. <UI> for the main thread, <BG> for anything else.
 
 Only the first parameter needs to be passed to this funtion.
 
 The textual representation is obtained from the `object` using its protocol conformances, in the following
 order of preference: `CustomDebugStringConvertible` and `CustomStringConvertible`. Do not overload this function for
 your type. Instead, adopt one of the protocols mentioned above.
 
 :param: object   The object whose textual representation will be printed. If this is an expression, it is lazily evaluated.
 :param: file     The name of the file, defaults to the current file without the ".swift" extension.
 :param: function The name of the function, defaults to the function within which the call is made.
 :param: line     The line number, defaults to the line number within the file that the call is made.
 */
public func logging<T>(_ object: @autoclosure () -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    #if DEBUG
    let value = object()
    let stringRepresentation: String
    
    if let value = value as? CustomDebugStringConvertible {
        stringRepresentation = value.debugDescription
    } else if let value = value as? CustomStringConvertible {
        stringRepresentation = value.description
    } else {
        stringRepresentation = "\(value)"
    }
    let fileURL = URL(string: file)?.lastPathComponent ?? "Unknown file"
    let queue = Thread.isMainThread ? "main" : "back"
    let time = Date().toString(dateFormat: "HH:mm:ss.SSS")
    print("\(time) [\(queue)] [\(fileURL):\(line)] \(function): \n" + stringRepresentation)
    #endif
}
