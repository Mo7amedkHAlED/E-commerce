//
//  NewCollctionViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 24/08/2022.
//

import UIKit

class NewCollctionViewController: UIViewController {

    @IBOutlet weak var subCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var gridListButton: UIButton!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var sortButton: UIButton!
    
    
    let images: [UIImage] = [UIImage(named: "lunchScreen")!,UIImage(named: "category1")!,UIImage(named: "category2")!]
    let subCategoriesNames: [String] = ["T-shirts", "Crop tops", "Hoodies", "ddd"]
    
    var isList: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        registerCollectionView()
    }
     
    func registerCollectionView(){
        subCategoriesCollectionView.register(UINib(nibName: "SubCategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubCategoriesCollectionViewCell")
        subCategoriesCollectionView.delegate = self
        subCategoriesCollectionView.dataSource = self
        
        productsCollectionView.register(UINib(nibName: "GridProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GridProductCollectionViewCell")
        
        productsCollectionView.register(UINib(nibName: "ListProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ListProductCollectionViewCell")
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
    
    @IBAction func didTappedGrid_ListButton(_ sender: UIButton) {
        isList.toggle()
        let imageList = UIImage(named: "list")
        let imageGrid = UIImage(named: "grid")
        let image = isList == true ? imageGrid : imageList
        gridListButton.setImage(image, for: .normal)
        productsCollectionView.reloadData()
    }
    
    @IBAction func didTapppedSortButton(_ sender: UIButton) {
        print("didTapppedSortButton§")
        goToSortViewController()
    }
    
    
    func goToSortViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SortByViewController")
        viewController.modalPresentationStyle = .overFullScreen
        
        //MARk:- additional layout to the view show from button 
        
        let transtion = CATransition()
        transtion.duration = 0.2
        transtion.type = .fade
        view.window?.layer.add(transtion, forKey: kCATransition)
        present(viewController, animated: false)
    }
    
}


extension NewCollctionViewController : CollectionView_Delegate_DataSource_FlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == subCategoriesCollectionView {
            return 2
        }else if collectionView == productsCollectionView {
            return 5
        }else{
            return 0
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case subCategoriesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoriesCollectionViewCell", for: indexPath) as!  SubCategoriesCollectionViewCell
            cell.categoryNameLabel.text = subCategoriesNames[indexPath.row]
            return cell
        default:
            if isList == true {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListProductCollectionViewCell", for: indexPath) as! ListProductCollectionViewCell
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridProductCollectionViewCell", for: indexPath)
                return cell
            }
            
        }
       
    }
    
    
}


extension NewCollctionViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case subCategoriesCollectionView:
            let width = view.frame.width
            let height = collectionView.frame.height - 16
            return CGSize(width: width / 3, height: height)
        default:
            if isList == true {
                let width = collectionView.frame.width
                return CGSize(width: width, height: 150)
            }else{
                let width = collectionView.frame.width
                return CGSize(width: width / 2, height: 236)
            }
            
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
