//
//  NetworkRequest.swift
//  Marvelgram
//
//  Created by Tim Akhm on 07.02.2022.
//
//

import UIKit

class NetworkRequest {
    
    static let shared = NetworkRequest()
    private init() {}
    func requestData(completion: @escaping (Result<Data, Error>) -> Void) {
        
        let urlString = NetworkConstants.shared.serverAddress
        guard let url = URL(string: urlString) else { return }
        
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue(label: "queues.serial")
        
        dispatchGroup.enter()
        
        asyncLoadImage(imageURL: URL(string: urlString)!,
                       runQueue: queue,
                       completionQueue: DispatchQueue.main) { data, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            completion(.success(data))
            dispatchGroup.leave()
        }
    }
}

private extension NetworkRequest {
    func asyncLoadImage(
        imageURL: URL,
        runQueue: DispatchQueue,
        completionQueue: DispatchQueue,
        completion: @escaping (Data?, Error?) -> ()) {
        runQueue.async {
            do {
                let data = try Data(contentsOf: imageURL)
                //sleep останавливает очередь на заданное время
                //arc4random дает нам рандомное время
                sleep(arc4random() % 4)
                completionQueue.async { completion(data, nil) }
            } catch let error {
                completionQueue.async { completion(nil, error) }
            }
        }
    }
}
