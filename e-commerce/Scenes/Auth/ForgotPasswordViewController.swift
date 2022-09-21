//
//  ForgotPasswordViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 21/09/2022.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
  
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var emailLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailLabel.addLayer()
        sendButton.addLayer()
    }


}
