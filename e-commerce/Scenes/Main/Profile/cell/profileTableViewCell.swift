//
//  profileTableViewCell.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 04/10/2022.
//

import UIKit

class profileTableViewCell: UITableViewCell {
    @IBOutlet weak var profileText: UILabel!
    @IBOutlet weak var ChosseButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
