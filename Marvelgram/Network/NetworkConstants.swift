//
//  URLString.swift
//  Marvelgram
//
//  Created by Tim Akhmetov on 26.01.2024.
//

import Foundation

class NetworkConstants {
    
    public static var shared: NetworkConstants = NetworkConstants()
    
    public var serverAddress: String {
        get {
            return "https://static.upstarts.work/tests/marvelgram/klsZdDg50j2.json"
        }
    }
}
