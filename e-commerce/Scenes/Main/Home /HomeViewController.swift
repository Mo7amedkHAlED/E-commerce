//
//  HomeViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 17/08/2022.
//

import UIKit
import Alamofire
import ProgressHUD

class HomeViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    
    
//    var image = [UIImage(named: "electronics"),UIImage(named: "jewelery"),UIImage(named: "men's clothing"),UIImage(named: "lunchScreen"),UIImage(named: "Pullover"),UIImage(named: "Shirt")]
//    let names: [String] = ["New collection", "Summer Sale", "Mean‘s hoodies"]
    var CategoriesArray : [CategoryDatum]?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Home"
        GetCategoriesApi()
        registerCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.topItem?.title = "Home" // to make title

        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func registerCollectionView(){
        collectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData() 
         
    }
    func GetCategoriesApi(){
        guard let url = URL(string: "https://student.valuxapps.com/api/categories") else { return}
        ProgressHUD.show("loading....")
        let header : HTTPHeaders = [.init(name: "lang", value: "en")]
        AF.request(url, method: .get ,headers: header).responseDecodable(of: BaseResponse<CategoriesModel>.self) { response in
            switch response.result{
            case .success(let AllCategries):
                ProgressHUD.dismiss()
                self.CategoriesArray = AllCategries.data?.data
                self.collectionView.reloadData()
                print(AllCategries)
            case .failure(let error):
                ProgressHUD.showError()
                print(error.localizedDescription)
            }
        }
        
    }

}


extension HomeViewController: CollectionView_Delegate_DataSource_FlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print(indexPath.row)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "NewCollctionViewController") as! NewCollctionViewController
            viewController.categoriesId = CategoriesArray?[indexPath.row]
            navigationController?.pushViewController(viewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoriesArray?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        let Categories = CategoriesArray![indexPath.row] // to take image name
        //cell.categoryImage.image = image[indexPath.row]
        cell.categoryImage.loadImage(urlString: Categories.image ?? "")
        cell.categoryNameLabel.text = Categories.name
        return cell
    }
    
}


extension HomeViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = (collectionView.frame.height / 2) - 24
        switch indexPath.row {
        case 0:
            print(indexPath.row ,width)
            return CGSize(width: width  , height: height)
        default:
            print(width / 2)
            return CGSize(width: width / 2, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


