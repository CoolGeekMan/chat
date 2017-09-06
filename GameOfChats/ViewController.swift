//
//  ViewController.swift
//  GameOfChats
//
//  Created by Raman Liulkovich on 9/6/17.
//  Copyright © 2017 Raman Liulkovich. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
    }
    
    func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }

}

