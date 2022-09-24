//
//  NewCollctionViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 24/08/2022.
//
//delegate use to update collection view or to call back page to update your data
//delegate use in sort view and list Product view       (one to one)
//cloure used to update data used in Grid Product view  (one to one)
//NotificationCenter used to update data in before pages(one to more)
//NotificationCenter used in Product Details 
import UIKit

class NewCollctionViewController: UIViewController, sortBy, FavoriteButton {
   
    @IBOutlet weak var subCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var gridListButton: UIButton!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var sortButton: UIButton!
    
    var hidden :Bool = true
    let images: [UIImage] = [UIImage(named: "lunchScreen")!,UIImage(named: "category1")!,UIImage(named: "category2")!]
    let subCategoriesNames: [String] = ["T-shirts", "Crop tops", "Hoodies", "ddd"]
    
    var isList: Bool = true
    var product = [ProductModel]()
    //MARK: -  NotificationCenter prevent Memmoery Lack
    deinit{
        NotificationCenter.default.removeObserver(self) // return to this class
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        product=[
            .init(id: 1, image: "Pullover", title: "Pullover ", des: "Mango", price: Int(150.99), isFav: false),
            .init(id: 2, image: "T-shirt", title: "T-shirt ", des: "Mango", price: 200 , isFav: false),
            .init(id: 3, image: "category1", title: "T-shirt ", des: "Mango", price: Int(170.99), isFav: false),
        ]
        addobserve()
        registerCollectionView()
        navigationController?.hidesBarsOnSwipe = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.hidesBarsOnTap = true // by click hidden and apper
    }
    //MARK: - to create NotificationCenter (lisent)
    func addobserve(){ // self بمعني هنا
        
        NotificationCenter.default.addObserver(self, selector: #selector(favoriteNotification(_:)), name: Notification.Name("didTappedFavoriteButton"), object: nil)
    }
    //  #selector(T##@objc method)
    @objc func favoriteNotification(_ notification:Notification){
        let id = notification.userInfo?["id"] as! Int // بمعني اني بقوله هات القيمه اللي متخزنه في المفتاح ده
        let ISFavorite = notification.userInfo?["isFav"] as! Bool
        product.first(where: {$0.id == id})? .isFav = ISFavorite  //لو وصلت لللرقم ده قم بتغير الي المفضل اللي جيلك ده
        // can use for whitout closure
        productsCollectionView.reloadData()
        print("id = \(id)")
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
        isList = !isList
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
        let viewController = storyboard.instantiateViewController(withIdentifier: "SortByViewController") as! SortByViewController
        viewController.delegate = self
        viewController.modalPresentationStyle = .overFullScreen
        
        //MARk:- additional layout to the view show from button 
        
        let transtion = CATransition()
        transtion.duration = 0.2
        transtion.type = .fade
        view.window?.layer.add(transtion, forKey: kCATransition)
        present(viewController, animated: false)
    }
    
    func didChangeSort(title: String) {
        sortButton.setTitle(title, for: .normal)
    }
    
}


extension NewCollctionViewController : CollectionView_Delegate_DataSource_FlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stryboard = UIStoryboard(name: "Main", bundle: nil) // to dispaly page which will go to it
        let viewcontroller = stryboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        viewcontroller.Product = product[indexPath.row] // to pass values to next view controller
        
        viewcontroller.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == subCategoriesCollectionView {
            return 2
        }else if collectionView == productsCollectionView {
            return product.count
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
                cell.productImage.image = UIImage(named: product[indexPath.row].image)
                cell.nameLabel.text = product[indexPath.row].title
                cell.desLabel.text = product[indexPath.row].des
                cell.priceLAbel.text = String("$\(product[indexPath.row].price)")
                cell.delegate = self
                cell.row = indexPath.row
                let image = product[indexPath.row].isFav == true ? UIImage(named: "favorite2") : UIImage(named: "favorite1")
                cell.FavoriteButton.setImage(image, for: .normal)
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridProductCollectionViewCell", for: indexPath) as!GridProductCollectionViewCell
                cell.productImage.image = UIImage(named: product[indexPath.row].image)
                cell.nameLabel.text = product[indexPath.row].title
                cell.desLabel.text = product[indexPath.row].des
                cell.priceLabel.text = String("$\(product[indexPath.row].price) ")
                cell.row = indexPath.row
                cell.didTappedFavroiteButtonClosure = { [weak self]row in
                    guard let self = self else { return }
                    self.didTappedFavoriteButton(row)
                    /* sالسطر اللي فوق ده بدل الثلاثه دول بيتم استدعاء الداله من البرتكول
                    let isFavorite = self.product[row].isFav
                    self.product[row].isFav = !isFavorite
                    self.productsCollectionView.reloadData()
                     */
                }
                let image = product[indexPath.row].isFav == true ? UIImage(named: "favorite2") : UIImage(named: "favorite1")
                cell.favoriteButton.setImage(image, for: .normal)
                return cell
            }
            
        }
       
    }
    //MARK: - protocol function
    func didTappedFavoriteButton(_ row: Int) {
        let isFavorite = product[row].isFav // to know is fav vlue in array
        product[row].isFav = !isFavorite  // to change value when choose
        productsCollectionView.reloadData() // to reload data
        
    }
    
    
}


extension NewCollctionViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case subCategoriesCollectionView:
            let width = collectionView.frame.width
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
