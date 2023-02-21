//
//  ForgotPasswordViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 21/09/2022.
//

import UIKit
import Alamofire
import ProgressHUD

class ForgotPasswordViewController: UIViewController {
  
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var emailLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailLabel.addLayer()
        sendButton.addLayer()
    }

    
    @IBAction func sendButton(_ sender: UIButton) {
//        guard let url = URL(string: "https://student.valuxapps.com/api/verify-email") else{return}
//        ProgressHUD.show("Loading... ")
//        AF.request(url, method: .post).responseDecodable(of: BaseResponse<forgetModel>.self) { respones in
//            switch respones.result{
//            case.success(let forget):
//                ProgressHUD.showSucceed(forget.message)
//            case.failure(let error):
//                ProgressHUD.showError()
//            }
//        }
    }
}
