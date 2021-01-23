//
//  NetworkManager.swift
//  Weather Russia
//
//  Created by Александр on 14.01.2021.
//

import Foundation

struct NetworkManager {
    
    private let key = "8f525b6eba3f4b535bd8808e42291e1a"
    
    func weatherUrl(city: String, completionHandler: @escaping(ModelWeather) -> Void) {
        let stringUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(key)&units=metric"
        guard let url = URL(string: stringUrl) else {return}
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                guard let currentWeather = parse(data: data) else {return}
                completionHandler(currentWeather)
            }
        }
        task.resume()
    }
    
    private func parse(data: Data) -> ModelWeather? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodModel = try decoder.decode(JsonModelWeather.self, from: data)
            guard let modelWeather = ModelWeather(jsonModelWeather: decodModel) else {return nil}
            return modelWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
