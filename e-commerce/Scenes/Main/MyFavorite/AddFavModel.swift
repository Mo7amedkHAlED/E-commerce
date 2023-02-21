//
//  AddFavModel.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 12/10/2022.
//

import Foundation
// MARK: - DataClass
class AddFavModel: Codable {
    var id: Int
    var product: Product
}

// MARK: - Product
class Product: Codable {
    var id, price, oldPrice, discount: Int
    var image: String

    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image
    }
}
