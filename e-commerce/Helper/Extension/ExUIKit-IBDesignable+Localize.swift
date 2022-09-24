//
//  ExUIKit-IBDesignable+Localize.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 24/09/2022.
//

import UIKit


//MARK: - extension to add localizeKey to any ul label

@IBDesignable public extension UILabel {
    @IBInspectable var localizeKey: String? {
        get {
            return self.text
        }
        
        set { // go to any lable and write your localized key
            //localized key اللي هو المسوال عن احتواء اللغه العربيه والانجليزيه
            self.text = newValue?.localized
        }
    }
}

//MARK: - extension to add localizeKey to any UIButton

@IBDesignable public extension UIButton {
    @IBInspectable var localizeKey: String? {
        get { self.titleLabel?.text }
        
        set {
            self.setTitle(newValue?.localized, for: .normal)
        }
    }
}

