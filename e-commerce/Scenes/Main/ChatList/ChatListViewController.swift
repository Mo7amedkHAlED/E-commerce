//
//  ChatListViewController.swift
//  e-commerce
//
//  Created by Mohamed Khaled on 21/09/2022.
//

import UIKit

class ChatListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCollectionView()
    }
    
    func registerCollectionView(){
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self

        }
}
extension ChatListViewController :Table_Delegate_DataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // conect to label hight
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        switch indexPath.row{
        case 0 , 2 :
            cell.StackView.alignment = .leading
            cell.ChatLabel.text = "Light blouse in soft cotton jersey with decorative buttons down the front and a wide ,"
        default :
            cell.StackView.alignment = .trailing
            cell.ChatLabel.text = "Light blouse in soft cotton jersey with decorative buttons down the front and a wide ,\nLight blouse in soft cotton jersey with decorative buttons down the front and a wide ,"
        }
        cell.selectionStyle = .none
         return cell
    }
    
        
    }
