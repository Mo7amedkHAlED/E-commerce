//
//  ProductModel.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 22/09/2022.
//

import Foundation
import UIKit

class ProductModel{
    // item come from new collection and go to product details
    var id : Int
    var image :String
    var title : String
    var des : String
    var price : Int
    var isFav : Bool
    
    init (id : Int, image : String, title : String, des : String, price : Int, isFav :Bool = false){
        self.id = id
        self.image = image
        self.title = title
        self.des = des
        self.price = price
        self.isFav = isFav
    }
    
}
