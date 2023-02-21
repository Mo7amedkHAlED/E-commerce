//
//  MyFavoriteCollectionViewCell.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 02/10/2022.
//

import UIKit
import ProgressHUD
import Alamofire
//MARK: - mack delgate protocol to change cart image
//protocol DeleteItem {
//    func didTappedDelecteButton(_ row: Int)
//}

class MyFavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var DeleteButton: UIButton!
    var itemId : getFavDatum?
    var deleteDelegate: DeleteItem?
    var cartRow: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func deleteButton(_ sender: UIButton) {
        let userToken = UserDefaults.standard.string(forKey: "LoginToken")
        let productId = itemId?.product.id
        let headers: HTTPHeaders = ["Authorization":userToken!,"lang" : "en"]
        let params:[String:Int] = ["product_id": productId!]
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
        guard let row = cartRow else {return}
        
        deleteDelegate?.didTappedDelecteButton(row)

    }
    
//    @IBAction func ChangeBagImage(_ sender: UIButton) {
//
//    }
    
}
