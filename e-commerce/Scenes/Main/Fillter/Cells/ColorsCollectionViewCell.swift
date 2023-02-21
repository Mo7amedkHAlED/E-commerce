//
//  ColorsCollectionViewCell.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 29/09/2022.
//

import UIKit

class ColorsCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.height * 0.5
        
//       Helper.customViews(views: [colorView], cornerRadius: 1)
//
    }
    
    override var isSelected: Bool {
        didSet{
            if isSelected{
                self.layer.borderWidth = 2
                self.layer.borderColor = UIColor.black.cgColor
            }else{
                self.layer.borderWidth = 0
                self.layer.borderColor = UIColor.white.cgColor
            }
            
        }
    }

}
