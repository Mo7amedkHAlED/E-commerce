//
//  MyFavoriteViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 02/10/2022.
//

import UIKit
import Alamofire
import ProgressHUD

class MyFavoriteViewController: UIViewController, DeleteItem {

    @IBOutlet weak var subCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    var subCategoriescolleectionArray = ["Electrionic Devices" , "Prevent Corona" , "sports" , "Clothes"]
    var FavArray2 = [getFavDatum]()
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "MyFavorite"
        addobserve()
        subCategoriesCollectionView.delegate = self
        subCategoriesCollectionView.dataSource = self
        subCategoriesCollectionView.register(UINib(nibName: "SubCategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubCategoriesCollectionViewCell")
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.register(UINib(nibName: "MyFavoriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyFavoriteCollectionViewCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavApi()
        productCollectionView.reloadData()
        navigationController?.navigationBar.topItem?.title = "MyFavorite"

    }
    func getFavApi(){
        let userToken =  UserDefaults.standard.string(forKey: "LoginToken")!

        guard let url = URL(string: "https://student.valuxapps.com/api/favorites")else {return}
        ProgressHUD.show("Loading.... 🥺")
        let headers: HTTPHeaders = ["Authorization":userToken,"lang" : "en"]
        AF.request(url, method: .get,encoding: JSONEncoding.default,headers:headers).responseDecodable(of: BaseResponse<GetFavModel>.self) { respone in
            switch respone.result{
            case.success(let getFav):
                ProgressHUD.dismiss()
                print(getFav)
                self.FavArray2 = getFav.data?.data ?? []
                print(self.FavArray2)
                self.productCollectionView.reloadData()
            case.failure(let error):
                ProgressHUD.showError()
                print(error)
            }
        }
    }
    
    func addobserve(){

        NotificationCenter.default.addObserver(self, selector: #selector(favoriteNotification(_:)), name: Notification.Name("AddToFavCV"), object: nil)
   }
   @objc func favoriteNotification(_ notification:Notification){
       let nameLabel = notification.userInfo?["nameLabel"] as! String
       let desLabel = notification.userInfo?["desLabel"] as! String
       FavArray2.first(where: {$0.product.name == nameLabel})? .product.name = nameLabel
       FavArray2.first(where: {$0.product.productDescription == desLabel})? .product.productDescription = desLabel
       productCollectionView.reloadData()
   }
}
extension MyFavoriteViewController : CollectionView_Delegate_DataSource_FlowLayout{
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch collectionView{
    case subCategoriesCollectionView:
        return subCategoriescolleectionArray.count
    default:
        return FavArray2.count
    }
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch collectionView{
    case subCategoriesCollectionView:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoriesCollectionViewCell", for: indexPath) as!  SubCategoriesCollectionViewCell
        cell.categoryNameLabel.text = subCategoriescolleectionArray[indexPath.row]
        return cell
    default:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyFavoriteCollectionViewCell", for: indexPath) as! MyFavoriteCollectionViewCell
        cell.itemId = FavArray2[indexPath.row]
        cell.desLabel.text = FavArray2[indexPath.row].product.productDescription
        cell.priceLabel.text = String(format: "%.1f",FavArray2[indexPath.row].product.price)
        cell.imageLabel.loadImage(urlString: (FavArray2[indexPath.row].product.image)!)
        cell.titleLabel.text = FavArray2[indexPath.row].product.name
        cell.deleteDelegate = self
        cell.cartRow = indexPath.row
        return cell
        }
    }
 //MARK: - protocal func to change image
    func didTappedDelecteButton(_ row: Int) {
        FavArray2.remove(at: row)
        productCollectionView.reloadData()
    }
}
extension MyFavoriteViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case subCategoriesCollectionView:
            let width = collectionView.frame.width - 24
            let height = collectionView.frame.height
            return CGSize(width: width / 3, height: height)
        default:
            
            
            let width = collectionView.frame.width
            let height = collectionView.frame.height
            return CGSize(width: width , height: 160  )
            
            
        }
    }
}
