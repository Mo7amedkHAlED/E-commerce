//
//  BagModel.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 13/10/2022.
//

import Foundation
// MARK: - DataClass
class BagModel: Codable {
    let cartItems: [BagItemDatum]
    let subTotal, total: Double

    enum CodingKeys: String, CodingKey {
        case cartItems = "cart_items"
        case subTotal = "sub_total"
        case total
    }
}

// MARK: - CartItem
class BagItemDatum: Codable {
    let id, quantity: Int
    let product: BagProduct
}

// MARK: - Product
class BagProduct: Codable {
    let id: Int?
    let price, oldPrice: Double?
    let discount: Int?
    let image: String?
    let name, productDescription: String?
    let images: [String]?
    let inFavorites, inCart: Bool?

    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name
        case productDescription = "description"
        case images
        case inFavorites = "in_favorites"
        case inCart = "in_cart"
    }
}
