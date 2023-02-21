//
//  ListProductCollectionViewCell.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 31/08/2022.
//

import UIKit
import Alamofire
import ProgressHUD
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
    var product2 : CategoryDetailsDatum?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        productImage.layer.cornerRadius = 8
    }
    @IBAction func FavoriteButton(_ sender: UIButton) {
       
        //MARK: - MAKE NOTIFICATION CENTER
        guard let row = row else {return}
        let userToken = UserDefaults.standard.string(forKey: "LoginToken")
        let headers: HTTPHeaders = ["Authorization":userToken!,"lang" : "en"]
        let params:[String:Int] = ["product_id": (product2?.id)!]
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
        delegate?.didTappedFavoriteButton(row)
    }
    
}
