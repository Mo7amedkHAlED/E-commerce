//
//  CategoryDetails.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 11/10/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - DataClass
class CategoryDetailsModel: Codable {
    var data: [CategoryDetailsDatum]
}

// MARK: - Datum
class CategoryDetailsDatum: Codable {
    var id: Int?
    var price, oldPrice: Double?
    var discount: Int?
    var image: String?
    var name, datumDescription: String?
    var images: [String]?
    var inFavorites, inCart: Bool

    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name
        case datumDescription = "description"
        case images
        case inFavorites = "in_favorites"
        case inCart = "in_cart"
    }
}
