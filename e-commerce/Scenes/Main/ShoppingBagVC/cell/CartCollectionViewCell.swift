//
//  CartCollectionViewCell.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 02/10/2022.
//

import UIKit
import Alamofire
protocol DeleteItem {
    func didTappedDelecteButton(_ row: Int)
}
class CartCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DesLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var deleteDelegate : DeleteItem?
    var itemId : BagItemDatum?
    var row : Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 8
    }
    @IBAction func DeleteButton(_ sender: UIButton) {
        guard let row = row else {return}
        deleteDelegate?.didTappedDelecteButton(row)
        DeleteBagItemApi()
    }
    func DeleteBagItemApi(){
        let headers: HTTPHeaders = ["Authorization":"buuEt2XlValHokbFBIvIq6ZKW23NuzOSwKs4EExcDqDnOLkrLKZ0RTXNNAhk5LgjFShA6i","lang" : "en"]
        let CategoryId = itemId?.product.id
        print(CategoryId)
        let params:[String:Int] = ["product_id": CategoryId!]
        guard let url = URL(string: "https://student.valuxapps.com/api/carts")else {return}
        AF.request(url, method: .post,parameters: params,encoding: JSONEncoding.default,headers:headers).responseDecodable(of: BaseResponse<AddFavModel>.self) { respone in
            switch respone.result{
            case.success(let item):
                print("")
            case.failure(let error):
                print("")
            }
        }
    }
    
}
