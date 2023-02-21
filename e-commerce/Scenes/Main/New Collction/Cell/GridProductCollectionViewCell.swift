//
//  GridProductCollectionViewCell.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 31/08/2022.
//

import UIKit
import Alamofire
import ProgressHUD
import ProgressHUD
class GridProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    var row : Int?
    var product1 : CategoryDetailsDatum?
    var didTappedFavroiteButtonClosure: ((_ row:Int)->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        productImage.layer.cornerRadius = 10
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        guard let row = row else {return}        // if null return nothing
        let userToken = UserDefaults.standard.string(forKey: "LoginToken")
        let headers: HTTPHeaders = ["Authorization":userToken!,"lang" : "en"]
        let params:[String:Int] = ["product_id": (product1?.id)!]
        guard let url = URL(string: "https://student.valuxapps.com/api/favorites")else {return}
        ProgressHUD.show()
        AF.request(url, method: .post,parameters: params,encoding: JSONEncoding.default,headers:headers).responseDecodable(of: BaseResponse<AddFavModel>.self) { respone in
            switch respone.result{
            case.success(let fav):
                ProgressHUD.showSucceed()
            case.failure(let error):
                ProgressHUD.showError()
            }
        }
        
        
        
        didTappedFavroiteButtonClosure?(row)
    }
    
}
