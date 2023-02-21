//
//  CategoriesModel.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 10/10/2022.
//

import Foundation


// MARK: - DataClass
struct CategoriesModel: Codable {
    let data: [CategoryDatum]?

}

// MARK: - Datum
struct CategoryDatum: Codable {
    let id: Int?
    let name: String?
    let image: String?
}
