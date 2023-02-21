//
//  MessagesViewController.swift
//  e-commerce
//
//  Created by Diaa SALAM on 08/08/2022.
//

import UIKit

class MessagesViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Messages" // to make title
        // Do any additional setup after loading the view.
        registerCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Messages" // to make title

    }
    func registerCollectionView(){
        tableview.register(UINib(nibName: "MessagesTableViewCell", bundle: nil), forCellReuseIdentifier: "MessagesTableViewCell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.reloadData()
        
    }

}

extension MessagesViewController : Table_Delegate_DataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesTableViewCell", for: indexPath) as! MessagesTableViewCell
        cell.selectionStyle = .none // disable the selection shadow
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ViewController = storyboard.instantiateViewController(withIdentifier: "ChatListViewController") // collection view not cell
        navigationController?.pushViewController(ViewController, animated: true)
    }
    
}
