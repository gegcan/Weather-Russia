//
//  JsonModelCitys.swift
//  Weather Russia
//
//  Created by Александр on 14.01.2021.
//

import Foundation

struct JsonModel: Codable {
    let cityRu: [String]
    let cityEn: [String]
}
