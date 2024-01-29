//
//  NetworkDataFetch.swift
//  Marvelgram
//
//  Created by Tim Akhm on 07.02.2022.
//

import Foundation

public class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    private init() {}
    
    func fetchHero(responce: @escaping ([HeroMarvelModel]?, Error?) -> Void) {
        NetworkRequest.shared.requestData() { result in
            switch result {
            case .success(let data):
                do {
                    let hero = try JSONDecoder().decode([HeroMarvelModel].self, from: data)
                    responce(hero, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
