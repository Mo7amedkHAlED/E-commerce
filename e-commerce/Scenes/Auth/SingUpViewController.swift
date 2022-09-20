//
//  SingUpViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 15/08/2022.
//

import UIKit

class SingUpViewController: UIViewController {

    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var singUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameView.addLayer()
        emailView.addLayer()
        passwordView.addLayer()
        singUpButton.addLayer()
    }
     
}

