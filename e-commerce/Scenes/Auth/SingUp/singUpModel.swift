//
//  singUpModel.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 10/10/2022.
//

import Foundation

// MARK: - DataClass
struct SingUpModel: Codable {
    let name, phone, email: String?
    let id: Int?
    let image: String?
    let token: String?
}
