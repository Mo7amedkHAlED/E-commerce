//
//  SortByViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 31/08/2022.
//

import UIKit

protocol sortBy : AnyObject {
    func didChangeSort(title:String)
}
class SortByViewController: UIViewController {
    
    @IBOutlet var listViews: [UIView]! 
    
    @IBOutlet var listLabels: [UILabel]!
    
    var delegate : sortBy?
    
    var sortArray :[ String] = ["Popular","Newest","Customer review","Price: Highest to low"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        }
    }
    
    
    @IBAction
    func didTappedCloseButton(_ sender: UIButton){
        dismiss(animated: false) // to close ui view
    }
    
    
    @IBAction func didTappedListButtons(_ sender: UIButton) {
        let title = sortArray[sender.tag]
        delegate?.didChangeSort(title: title)
        listViews.forEach({$0.backgroundColor = .white})
        listViews.first(where: {$0.tag == sender.tag })?.backgroundColor = .purple
        
        for x in listLabels {
            if x.tag == sender.tag {
                x.textColor = .white
            }else{
                x.textColor = .black
            }
        }
        
    }
    
}
