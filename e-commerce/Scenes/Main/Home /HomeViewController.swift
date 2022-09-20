//
//  HomeViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 17/08/2022.
//

import UIKit

class HomeViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let images: [UIImage] = [UIImage(named: "lunchScreen")!,UIImage(named: "category1")!,UIImage(named: "category2")!]
    let names: [String] = ["New collection", "Summer Sale", "Mean‘s hoodies"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func registerCollectionView(){
        collectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
         
    }

}


extension HomeViewController: CollectionView_Delegate_DataSource_FlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "NewCollctionViewController")
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        cell.categoryImage.image = images[indexPath.row]
        cell.categoryNameLabel.text = names[indexPath.row]
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
            return CGSize(width: width, height: height)
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

