//
//  BaseResponse.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 10/10/2022.
//

import Foundation

class BaseResponse<T : Codable> : Codable{
    let status: Bool?
    let message: String?
    let data: T?
}
