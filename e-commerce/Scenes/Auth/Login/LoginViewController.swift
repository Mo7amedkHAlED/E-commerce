//
//  ViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 08/08/2022.
//

import UIKit
import MOLH
import Alamofire
import ProgressHUD
class LoginViewController: UIViewController {

    @IBOutlet weak var E_mailView: UIView!
    @IBOutlet weak var E_mailTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        E_mailView.addLayer()
        passwordView.addLayer()
        loginButton.addLayer()
    }
    
    
//    @IBAction func didTapped
    
    @IBAction func didPressLoginButton(_ sender: UIButton) {
        guard let e_mail = E_mailTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        LoginApi(e_mail: e_mail, password: password)
    }
    func LoginApi(e_mail:String , password : String){
        guard let url = URL(string: "https://student.valuxapps.com/api/login") else{return}
        ProgressHUD.show("Loading..... ")
        let params:[String:String] = ["email": e_mail,"password": password]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseDecodable(of:BaseResponse<SingUpModel>.self) { response in
            switch response.result{
            case .success(let loginModel):
            //MARK: - to save data in user default ,forKey = id unique
                UserDefaults.standard.set(loginModel.data?.token, forKey: "LoginToken") // becouse token is string value
                UserDefaults.standard.set(loginModel.data?.name, forKey: "UserName")
                UserDefaults.standard.set(loginModel.data?.image, forKey: "UserImage")
                ProgressHUD.colorHUD = .magenta
                ProgressHUD.showSucceed(loginModel.message)
                if loginModel.data?.token != nil{
                    self.goToTabBar()
                }
            case .failure(_):
                ProgressHUD.showFailed()
                
            }
        }
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
        nvg.modalPresentationStyle = .overFullScreen
         present(nvg, animated: true)
    }
    
    @IBAction func didTappedSingup(_ sender: UIButton) {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = stroyboard.instantiateViewController(withIdentifier: "SingUpViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func ForgotPassword(_ sender: UIButton) {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = stroyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    

    @IBAction func EnButton(_ sender: UIButton) {
        //MARK: - to change Language
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "en" : "en")
        MOLH.reset(transition: .transitionCrossDissolve, duration: 0.25)

    }
    @IBAction func ArButton(_ sender: UIButton) {
        //MARK: - to change Language

        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "ar" ? "ar" : "ar")
        MOLH.reset(transition: .transitionCrossDissolve, duration: 0.25)
    }
    
}
