//
//  NewMessageController.swift
//  GameOfChats
//
//  Created by Raman Liulkovich on 9/7/17.
//  Copyright © 2017 Raman Liulkovich. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {

    let cellId = "CellId"
    var users = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        fetchUser()
    }
    
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: Any] else {
                return
            }
            
            let user = User()
            user.name = dictionary["name"] as? String
            user.email = dictionary["email"] as? String
            self.users.append(user)
      
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
            
        }, withCancel: nil)
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
}
