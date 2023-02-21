//
//  profileModel.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 13/10/2022.
//

import Foundation
// MARK: - DataClass
struct profileDataClass: Codable {
    let id: Int?
    let name, email, phone: String?
    let image: String?
    let points, credit: Int?
    let token: String?
}
