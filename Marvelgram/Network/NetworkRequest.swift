//
//  NetworkRequest.swift
//  Marvelgram
//
//  Created by Тимур Ахметов on 07.02.2022.
// Синглтон нужен для того, чтобы обращение шло только к одному и тому же экземляру. "Определнный человек, который знает дорогу"
// Сетевой запрос/слой

import Foundation

class NetworkRequest {
    /// Статическое поле, управляющие доступом к экземпляру одиночки
    /// Эта реализация позволяет вам расширять класс Одиночки, сохраняя повсюду
    /// только один экземпляр каждого подкласса.(нельзя создать несколько экземпляров НетворкРеквест)
    static let shared = NetworkRequest()
    /// Инициализатор Одиночки всегда должен быть скрытым, чтобы предотвратить прямое создание объекта через инициализатор.
    private init() {}
    /// CompletionHandler - забегающее замыкание. Замыкание, которое работает после выполнения
    func requestData(completion: @escaping (Result<Data, Error>) -> Void) {
        
        let urlString = "https://static.upstarts.work/tests/marvelgram/klsZdDg50j2.json"
        guard let url = URL(string: urlString) else { return }
        
        //задача обработки данных: дата/ответ/ошибка
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            //Асинхронный режим
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                //если данные есть, передаются в success (Data)
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        //запуск запроса/отправка
        .resume()
    }
}
