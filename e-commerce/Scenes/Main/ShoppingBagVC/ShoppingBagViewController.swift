//
//  ShoppingBagViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 30/09/2022.
//

import UIKit
import ProgressHUD
import Alamofire

class ShoppingBagViewController: UIViewController, DeleteItem {


    @IBOutlet weak var SubCategoriesCollection: UICollectionView!
    @IBOutlet weak var MyBagCollection: UICollectionView!
    let images: [UIImage] = [UIImage(named: "lunchScreen")!,UIImage(named: "category1")!,UIImage(named: "category2")!]
    var subCategoriescolleectionArray = ["Electrionic Devices" , "Prevent Corona" , "sports" , "Clothes"]
    var product = [BagItemDatum]()
    var product1 = [ProductModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
         registerCollectionView()
        navigationController?.navigationBar.topItem?.title = "My Bag"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "My Bag"
        getBagDataApi()
    }
    func registerCollectionView(){
        SubCategoriesCollection.register(UINib(nibName: "SubCategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubCategoriesCollectionViewCell")
        SubCategoriesCollection.delegate = self
        SubCategoriesCollection.dataSource = self
        
        MyBagCollection.register(UINib(nibName: "CartCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CartCollectionViewCell")
        MyBagCollection.delegate = self
        MyBagCollection.dataSource = self
    }
    
    func getBagDataApi(){
        let userToken =  UserDefaults.standard.string(forKey: "LoginToken")!
        guard let url = URL(string: "https://student.valuxapps.com/api/carts")else {return}
        let headers: HTTPHeaders = ["Authorization":userToken,"lang" : "en"]
        ProgressHUD.show("Loading....🥺")
        AF.request(url, method: .get,encoding: JSONEncoding.default,headers:headers).responseDecodable(of: BaseResponse<BagModel>.self) {  respone in
            switch respone.result{
            case.success(let bagData):
                self.product = bagData.data!.cartItems
                self.MyBagCollection.reloadData()
                ProgressHUD.dismiss()
            case.failure(let error):
                print(error)
                ProgressHUD.showError()
            }
        }
    }

}

extension ShoppingBagViewController : CollectionView_Delegate_DataSource_FlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case SubCategoriesCollection:
            return subCategoriescolleectionArray.count
        default:
            return product.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
            case SubCategoriesCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoriesCollectionViewCell", for: indexPath) as! SubCategoriesCollectionViewCell
            cell.categoryNameLabel.text = subCategoriescolleectionArray[indexPath.row]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCollectionViewCell", for: indexPath) as! CartCollectionViewCell
            cell.itemId = product[indexPath.row]
            cell.imageView.loadImage(urlString: product[indexPath.row].product.image ?? " ")
            print(product[indexPath.row].product.name)
            cell.DesLabel.text = product[indexPath.row].product.productDescription
            cell.TitleLabel.text = product[indexPath.row].product.name
            cell.PriceLabel.text = String(format: "%.1f",(product[indexPath.row].product.price!))
            cell.deleteDelegate = self
            cell.row = indexPath.row
            return cell
        }
    }
    //MARK: -  func didTappedDelecteButton
    func didTappedDelecteButton(_ row: Int) {
        product.remove(at: row)
        MyBagCollection.reloadData()
    }
    
}
extension ShoppingBagViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case SubCategoriesCollection:
            let width = collectionView.frame.width - 24
            let height = collectionView.frame.height
            return CGSize(width: width / 3, height: height)
        default:
            let width = collectionView.frame.width
            let height = collectionView.frame.height
            return CGSize(width: width , height: 140  )
            
            
        }
    }
}

