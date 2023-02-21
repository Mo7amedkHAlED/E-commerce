//
//  ProfileViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 02/10/2022.
//

import UIKit
import Alamofire
import ProgressHUD

class ProfileViewController: UIViewController {
    @IBOutlet weak var settingUITableView: UITableView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var ProfileArray = ["Orders","Communtiot resources","Help & Support", " Setting"]
    var profileData : profileDataClass?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Profile"
        getProfileDataApi()
        settingUITableView.register(UINib(nibName: "profileTableViewCell", bundle: nil), forCellReuseIdentifier: "profileTableViewCell")
        settingUITableView.delegate = self
        settingUITableView.dataSource = self
        profileName.text = UserDefaults.standard.string(forKey: "UserName")!
        profileImage.loadImage(urlString: UserDefaults.standard.string(forKey: "UserImage")!)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Profile"

    }
    func getProfileDataApi(){
        guard let url = URL(string: "https://student.valuxapps.com/api/profile") else {return}
        let userToken = UserDefaults.standard.string(forKey: "LoginToken")!
        let headers: HTTPHeaders = ["Authorization": userToken,"lang" : "en"]
        ProgressHUD.show("Loading....🥺")
        AF.request(url, method: .get,encoding: JSONEncoding.default,headers:headers).responseDecodable(of: BaseResponse<profileDataClass>.self) { respone in
            switch respone.result{
            case.success(let profile):
                self.profileData = profile.data
                ProgressHUD.dismiss()
            case.failure(let error):
                ProgressHUD.showError()
            }
        }
    }

    @IBAction func logoutButton(_ sender: UIButton) {
        logoutAPi()
    }
        func logoutAPi(){
            let userToken =  UserDefaults.standard.string(forKey: "LoginToken")!
            print("userToken=\(userToken)")
            guard let url = URL(string: "https://student.valuxapps.com/api/logout") else {return}
            let headers: HTTPHeaders = ["Authorization":userToken,"lang" : "en"]
            ProgressHUD.show("Loading....🥺")
            AF.request(url, method: .post,encoding: JSONEncoding.default,headers:headers).responseDecodable(of: BaseResponse<logoutDataClass>.self) { respone in
                switch respone.result{
                case.success(let profile):
                    ProgressHUD.show(profile.message)
                    if profile.data?.token != nil{
                        ProgressHUD.dismiss()
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginViewController")
                        loginVC?.modalPresentationStyle = .fullScreen
                        self.present(loginVC!, animated: true, completion: {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                            })
                        
                        UserDefaults.standard.removeObject(forKey: "LoginToken")
                        UserDefaults.standard.synchronize()
                    }
                case.failure(let error):
                    ProgressHUD.dismiss()
                }
            }
        }
}
extension ProfileViewController:Table_Delegate_DataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return ProfileArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileTableViewCell", for: indexPath) as! profileTableViewCell
        cell.profileText.text = ProfileArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // conect to label hight
    }
  

    
}
