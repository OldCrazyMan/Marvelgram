//
//  NetworkDataFetch.swift
//  Marvelgram
//
//  Created by Тимур Ахметов on 07.02.2022.
//
//Получили данные и пытаеся их декодировать -> Создаем модель
//Fetch - извлечь-приведение
import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    private init() {}
    
    func fetchHero(responce: @escaping ([HeroMarvelModel]?, Error?) -> Void) {
        NetworkRequest.shared.requestData() { result in
            switch result {
                //если Успех, то создаем свойство Дата и с помощью DO декодируем
            case .success(let data):
                do {
                    let hero = try JSONDecoder().decode([HeroMarvelModel].self, from: data) //формат в который хотим декодировать  
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

//понали создавать функцию getHeroarray

