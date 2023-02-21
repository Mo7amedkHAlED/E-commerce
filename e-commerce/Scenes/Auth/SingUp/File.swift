//
//  File.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 12/02/2023.
//

import Foundation

// MARK: - Welcome
struct CitiesModel: Codable {
    let data: [CityData]
    let status, message: String
}

// MARK: - Datum
struct CityData: Codable {
    let id: Int
    let name: String
}
