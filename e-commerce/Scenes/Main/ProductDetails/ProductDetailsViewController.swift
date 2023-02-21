//
//  ProductDetailsViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 21/09/2022.
//

import UIKit
import Alamofire
import ProgressHUD

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productImage: UICollectionView!
    @IBOutlet weak var recommendProduct: UICollectionView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DescLAbel: UILabel!
    @IBOutlet weak var MoreDatails: UILabel!
    var Product :CategoryDetailsDatum? // define that is your type = struct
    var categoriesId : CategoryDatum?

    var image = [UIImage(named: "category1"),UIImage(named: "category2"),UIImage(named: "category1")]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Product?.name
        ChangeFavoriteButtonImage()
        registerCollectionView()
        NameLabel.text = Product?.name
        DescLAbel.text = Product?.datumDescription
        MoreDatails.text = Product?.datumDescription
        
    }
    func ChangeFavoriteButtonImage(){
        
        if Product?.inFavorites == true{
            let image = UIImage(named: "favorite2")
            favoriteButton.setImage(image, for: .normal)
        }else{
            let image = UIImage(named: "favorite1")
            favoriteButton.setImage(image, for: .normal)
        }
    }
    func registerCollectionView(){
        productImage.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        productImage.delegate = self
        productImage.dataSource = self
        recommendProduct.register(UINib(nibName: "GridProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GridProductCollectionViewCell")
        recommendProduct.delegate = self
        recommendProduct.dataSource = self
    
    }
    @IBAction func favoriteButton(_ sender: UIButton) {
        let isFav = Product?.inFavorites ?? false
        Product?.inFavorites = !isFav
        ChangeFavoriteButtonImage()
        //MARK: - to create NotificationCenter (post)
        guard let ProductIsFavorite = Product?.inFavorites else { return }
        guard let ProductId = Product?.id else { return }
        let userInfo : [String:Any] = ["id":ProductId,"isFav":ProductIsFavorite]
        NotificationCenter.default.post(name: Notification.Name("didTappedFavoriteButton"), object: nil,userInfo: userInfo)
        
    }
    @IBAction func AddToCart(_ sender: UIButton) {
        AddBagItemApi()
        
    }
    func AddBagItemApi(){
        let itemId = (Product?.id!)!
        let headers: HTTPHeaders = ["Authorization":"buuEt2XlValHokbFBIvIq6ZKW23NuzOSwKs4EExcDqDnOLkrLKZ0RTXNNAhk5LgjFShA6i","lang" : "en"]
        let params:[String:Int] = ["product_id": itemId]
        guard let url = URL(string: "https://student.valuxapps.com/api/carts")else {return}
        ProgressHUD.show()
        AF.request(url, method: .post,parameters: params,encoding: JSONEncoding.default,headers:headers).responseDecodable(of: BaseResponse<AddFavModel>.self) { respone in
            switch respone.result{
            case.success(let item):
                ProgressHUD.showSucceed()
            case.failure(let error):
                ProgressHUD.showError()
            }
        }
    }
}
extension ProductDetailsViewController:CollectionView_Delegate_DataSource_FlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case productImage :
            return  image.count
        default :
            return  image.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case productImage :
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            cell.categoryImage.loadImage(urlString: (Product?.image)!)
            cell.categoryNameLabel.isHidden = true
            return cell
        default :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridProductCollectionViewCell", for: indexPath) as! GridProductCollectionViewCell
            cell.productImage.loadImage(urlString: (Product?.image)!)
            return cell
    
        }
    }
    
}

extension ProductDetailsViewController{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case productImage:
            let width = collectionView.frame.width * 0.8 // 2/3 screen size
            let height = collectionView.frame.height
            return CGSize(width: width, height: height)
        default:
                let width = collectionView.frame.width / 2
                let height = collectionView.frame.height
                return CGSize(width: width, height: height)
            }
            
    }


}
 
