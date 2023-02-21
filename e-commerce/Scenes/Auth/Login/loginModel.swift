//
//  loginModel.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 10/10/2022.
//

import Foundation

// MARK: - DataClass == T in data in generic Model
struct LoginModel: Decodable {
    let id: Int?
    let name, email, phone: String?
    let image: String?
    let points, credit: Int?
    let token: String?
}

