//
//  ViewController.swift
//  GameOfChats
//
//  Created by Raman Liulkovich on 9/6/17.
//  Copyright © 2017 Raman Liulkovich. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "new_message_icon"), style: .plain, target: self, action: #selector(handleNewMessage))
        
        checkIfUserLoggenIn()
    }
    
    func handleNewMessage() {
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    
    func checkIfUserLoggenIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: {[weak self] (snapshot) in
                
                guard let strongSelf = self else {
                    return
                }
                
                guard let dictionary = snapshot.value as? [String: Any] else {
                    return
                }
                
                strongSelf.navigationItem.title = dictionary["name"] as? String
                
            }, withCancel: nil)
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

