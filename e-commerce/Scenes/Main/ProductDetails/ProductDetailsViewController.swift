//
//  ProductDetailsViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 21/09/2022.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productImage: UICollectionView!
    @IBOutlet weak var recommendProduct: UICollectionView!
    @IBOutlet weak var favoriteButton: UIButton!
    var Product :ProductModel? // define that is your type = struct
    // to catch info from last screen
    var image = [UIImage(named: "category1"),UIImage(named: "category2"),UIImage(named: "category1")]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Product?.title
        ChangeFavoriteButtonImage() // to be like as before page
        registerCollectionView()
        // Do any additional setup after loading the view.
        
    }
    func ChangeFavoriteButtonImage(){
        
        if Product?.isFav == true{
            let image = UIImage(named: "favorite2")
            favoriteButton.setImage(image, for: .normal)
        }else{
            let image = UIImage(named: "favorite1")
            favoriteButton.setImage(image, for: .normal)
        }
    }
    func registerCollectionView(){
        // Product Image collection view
        productImage.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        productImage.delegate = self
        productImage.dataSource = self
        //recommend Product collection view
        recommendProduct.register(UINib(nibName: "GridProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GridProductCollectionViewCell")
        recommendProduct.delegate = self
        recommendProduct.dataSource = self
    
    }
    @IBAction func favoriteButton(_ sender: UIButton) {
        let isFav = Product?.isFav ?? false
        Product?.isFav = !isFav
        ChangeFavoriteButtonImage() // to take control and change in anther pages
        //MARK: - to create NotificationCenter (post)
        guard let ProductIsFavorite = Product?.isFav else { return }
        guard let ProductId = Product?.id else { return }
        let userInfo : [String:Any] = ["id":ProductId,"isFav":ProductIsFavorite] // data which you need to send to change in other pages
        NotificationCenter.default.post(name: Notification.Name("didTappedFavoriteButton"), object: nil,userInfo: userInfo)
        
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
            cell.categoryImage.image = image[indexPath.row]
            cell.categoryNameLabel.isHidden = true
            return cell
        default :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridProductCollectionViewCell", for: indexPath) as! GridProductCollectionViewCell
           cell.productImage.image = image[indexPath.row]
            return cell
    
        }
    }
    
}

// extension for layout
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
 
