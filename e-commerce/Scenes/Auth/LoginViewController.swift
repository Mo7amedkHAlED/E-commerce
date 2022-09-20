//
//  ViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 08/08/2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailView: UIView!
  
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailView.addLayer()
        passwordView.addLayer()
        loginButton.addLayer()
    }
    
    
//    @IBAction func didTapped
    
    @IBAction func didPressLoginButton(_ sender: UIButton) {
        
        goToTabBar()
//        present(singupViewController, animated: true)
        print("didPressLoginButton")
    }
    
    func goToSingUp(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let singupViewController = storyboard.instantiateViewController(withIdentifier: "SingUpViewController")
        navigationController?.pushViewController(singupViewController, animated: true)
    }
    
    func goToTabBar(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        let nvg = UINavigationController(rootViewController: tabbar)
        nvg.modalPresentationStyle = .fullScreen
         present(nvg, animated: true)
    }
    
    @IBAction func didTappedSingup(_ sender: UIButton) {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = stroyboard.instantiateViewController(withIdentifier: "SingUpViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}



