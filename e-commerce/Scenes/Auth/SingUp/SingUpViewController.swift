//
//  SingUpViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 15/08/2022.
//

import UIKit
import Alamofire
import ProgressHUD
class SingUpViewController: UIViewController {

    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PhoneNumberView: UIView!
    @IBOutlet weak var PhoneNumberTextField: UITextField!
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
    @IBAction func BackToLoginPage(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        navigationController?.pushViewController(viewController, animated: true)
      
    }
    @IBAction func SingUpButton(_ sender: UIButton) {
        guard let name = nameTextField.text else { return}
        guard let email = emailTextField.text else { return}
        guard let password = passwordTextField.text else { return}
        guard let phoneNumber = PhoneNumberTextField.text else { return}
        singUpAPI(name: name, email: email, password: password ,phoneNumber : phoneNumber)
    }
    
    func singUpAPI(name : String , email : String , password : String, phoneNumber : String){
        guard let url = URL(string: "https://student.valuxapps.com/api/register") else { return}
        ProgressHUD.show("Loading..... ")
        let params : [String:String] = ["name" : name , "email" : email , "password" : password,"phone" : phoneNumber]
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseDecodable(of: BaseResponse<SingUpModel>.self) { response in
            switch response.result {
            case .success(let singupModel):
                print(singupModel.data?.token)
                ProgressHUD.colorHUD = .magenta
                ProgressHUD.showSucceed(singupModel.message)
            case .failure(let error):
                ProgressHUD.showFailed()
                
            }
        }
    }
}

