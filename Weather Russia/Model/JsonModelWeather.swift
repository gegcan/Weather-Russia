//
//  JsonModelWeather.swift
//  Weather Russia
//
//  Created by Александр on 14.01.2021.
//

import Foundation

struct JsonModelWeather: Codable {
    let name: String
    let main: Main
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
}
