import Foundation
import UIKit
 // to create cornerRadius
extension UIView{
        @IBInspectable var cornerRadius : CGFloat {
        get{return cornerRadius}
        set{
            self.layer.cornerRadius = newValue
            
        }
    }
}
//
//  CornerEx.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 20/09/2022.
//

import Foundation
