////
////  forgotModel.swift
////  e-commerce
////
////  Created by Mohamed Khaled on 10/10/2022.
////
//
//import Foundation
//
//class forgetModel: Codable, Hashable {
//
//    public static func == (lhs: forgetModel, rhs: forgetModel) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(forgetModel.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
