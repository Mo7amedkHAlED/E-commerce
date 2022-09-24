//
//  GridProductCollectionViewCell.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 31/08/2022.
//

import UIKit

class GridProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    var row : Int?
    var didTappedFavroiteButtonClosure: ((_ row:Int)->Void)? // called back by clousure
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        productImage.layer.cornerRadius = 10
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        guard let row = row else {          // if null return nothing
            return
        }
        didTappedFavroiteButtonClosure?(row)
    }
    
}
