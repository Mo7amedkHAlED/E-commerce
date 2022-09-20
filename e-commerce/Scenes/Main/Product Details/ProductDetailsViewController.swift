//
//  ProductDetailsViewController.swift
//  e-commerce
//
//  Created by Diaa Mohamed Khaled on 12/09/2022.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    @IBOutlet weak var recommendPrdouctCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
    }
    
    func registerCollectionView(){
        productImagesCollectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        productImagesCollectionView.delegate = self
        productImagesCollectionView.dataSource = self
        
        
        recommendPrdouctCollectionView.register(UINib(nibName: "GridProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GridProductCollectionViewCell")
        recommendPrdouctCollectionView.delegate = self
        recommendPrdouctCollectionView.dataSource = self
    
    }
}


extension ProductDetailsViewController: CollectionView_Delegate_DataSource_FlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case productImagesCollectionView:
            return 3
        default:
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case productImagesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            cell.categoryNameLabel.isHidden = true
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridProductCollectionViewCell", for: indexPath)
            return cell
            
        }
    }
}


extension ProductDetailsViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case productImagesCollectionView:
            let width = collectionView.frame.width * 0.8
            let height = collectionView.frame.height
            return CGSize(width: width, height: height)
        default:
            let width = collectionView.frame.width / 2
            let hight = collectionView.frame.height
            return CGSize(width: width, height: hight)
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
