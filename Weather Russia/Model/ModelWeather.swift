//
//  ModelWeather.swift
//  Weather Russia
//
//  Created by Александр on 15.01.2021.
//

import Foundation

struct ModelWeather {
    
    let name: String
    let temp: Double
    var tempString: String {
        return "\(temp)"
    }
    let feels_like: Double
    var feelsLike: String {
        return "\(feels_like)"
    }
    
    init?(jsonModelWeather: JsonModelWeather) {
        name = jsonModelWeather.name
        temp = jsonModelWeather.main.temp
        feels_like = jsonModelWeather.main.feels_like
    }
}
