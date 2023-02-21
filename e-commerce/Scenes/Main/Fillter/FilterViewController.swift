//
//  FilterViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 29/09/2022.
//

import UIKit
protocol UsenigColorFilterProtocol {
    func didUserUseingColorFilter(name: String? , color: UIColor?)
    func didUserTappCancelOrDoneButton(tabBar: UITabBar?)
}
class FilterViewController: UIViewController {
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var colorsArray = [#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) , #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) , #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1) , #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1) , #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) , #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1) , #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1) , #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1) , #colorLiteral(red: 0, green: 0.6783193946, blue: 0.6451055408, alpha: 1) ]
    var categoryNamesArray = ["All","Men","Women","Boys","Girls"]
    var delegate : UsenigColorFilterProtocol?
    var currentColor = UIColor()
    var currentCategoryName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        colorsCollectionView.delegate = self
        colorsCollectionView.dataSource = self
        colorsCollectionView.register(UINib(nibName: "ColorsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColorsCollectionViewCell")
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7) // نسبه الشفافيه ui view
        }
    }
    @IBAction
    func didTappedCloseButton(_ sender: UIButton){
        delegate?.didUserTappCancelOrDoneButton(tabBar: self.tabBarController?.tabBar)
        dismiss(animated: false) // to close ui view
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        filterAlert()
    }
    func filterAlert () {
        let alert = UIAlertController(title: "Confirm Filter", message: "are you sure to use filter", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            
            // Send data (name and color) by protocol delegate
            self.delegate?.didUserTappCancelOrDoneButton(tabBar: self.tabBarController?.tabBar)
            self.delegate?.didUserUseingColorFilter(name: self.currentCategoryName, color: self.currentColor)
           
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            self.dismiss(animated: true)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}



extension FilterViewController : CollectionView_Delegate_DataSource_FlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case colorsCollectionView :
            return colorsArray.count
        default:
            return categoryNamesArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case colorsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorsCollectionViewCell", for: indexPath) as! ColorsCollectionViewCell
            cell.backgroundColor = colorsArray[indexPath.row]
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cell.categoryLBL.text = categoryNamesArray[indexPath.row]
            return cell
            
        }
    }
     
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentColor = colorsArray[indexPath.row]
        currentCategoryName = categoryNamesArray[indexPath.row]
        
    }
    
            //MARK: - For size and layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width , height = collectionView.frame.height
        if collectionView == categoryCollectionView {

            return CGSize(width: width / 3  , height: height  / 2  )
        }else{
            return CGSize(width: 25    , height: 25 )

        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == categoryCollectionView {
            return 0
        }else{
            return 16
        }
        

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == categoryCollectionView {
            return 0
        }else{
            return 16
        }
            }
        
}
