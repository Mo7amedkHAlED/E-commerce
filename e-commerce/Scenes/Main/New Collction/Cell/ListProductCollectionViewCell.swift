//
//  ListProductCollectionViewCell.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 31/08/2022.
//

import UIKit
protocol FavoriteButton{
    func didTappedFavoriteButton(_ row:Int)
}
class ListProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var priceLAbel: UILabel!
    @IBOutlet weak var FavoriteButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    var delegate : FavoriteButton?
    var row : Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        productImage.layer.cornerRadius = 8
    }
    @IBAction func FavoriteButton(_ sender: UIButton) {
       
        // item id to detect whitch item choose
        guard let row = row else {
            return
        }
        delegate?.didTappedFavoriteButton(row)
    }
    
}
