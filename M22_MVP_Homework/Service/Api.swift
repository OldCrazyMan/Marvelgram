//
//  Api.swift
//  KinoBOX
//
//  Created by Sergey Savinkov on 24.10.2023.
//

import Foundation

struct APIKEY {
    static let apiKey = "340b88ed-dbaf-4c41-b849-45ae0ba0066c"
}

struct URLString {
    enum ServerURL: String {
        case keyURL = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword="
        case top100URL = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS&page="
        case top250URL = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page="
        case topAwaitURL = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_AWAIT_FILMS&page="
    }
}
