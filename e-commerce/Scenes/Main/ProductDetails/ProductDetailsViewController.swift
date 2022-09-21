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
    
    var image = [UIImage(named: "category1"),UIImage(named: "category2"),UIImage(named: "category1")]
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        // Do any additional setup after loading the view.
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
 
