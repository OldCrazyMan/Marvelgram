//
//  NetworkRequest.swift
//  Marvelgram
//
//  Created by Тимур Ахметов on 07.02.2022.
//
//

import Foundation

class NetworkRequest {
    
    static let shared = NetworkRequest()
    private init() {}
    func requestData(completion: @escaping (Result<Data, Error>) -> Void) {
        
        let urlString = "https://static.upstarts.work/tests/marvelgram/klsZdDg50j2.json"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        .resume()
    }
}
