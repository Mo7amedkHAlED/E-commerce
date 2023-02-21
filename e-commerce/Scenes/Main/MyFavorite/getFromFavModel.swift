//
//  getFromFavModel.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 12/10/2022.
//

import Foundation
// MARK: - DataClass
class GetFavModel: Codable {
    var data: [getFavDatum]
}

// MARK: - Datum
class getFavDatum: Codable {
    var id: Int?
    var product: favProduct
}

// MARK: - Product
class favProduct: Codable {
    var id :Int
    var price, oldPrice, discount: Double
    var image: String?
    var name, productDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name
        case productDescription = "description"
    }
}
