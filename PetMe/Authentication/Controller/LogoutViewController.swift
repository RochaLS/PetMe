//
//  LogoutViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-13.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogoutViewController: UIViewController {
    
    let logoutButton: UIButton = {
        let button = DefaultButton()
        button.setTitle("Sign Out", for: .normal)
        button.addTarget(self, action: #selector(signOutUser), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        setupViews()
    }
    
    @objc func signOutUser() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            goToLogin()
            
        } catch let error {
            print(error)
        }
    }
    
    func setupViews() {
        view.addSubview(logoutButton)
        
        view.addContraintsWithFormat(format: "V:|-\(44 + 60)-[v0(50)]", views: logoutButton)
        view.addContraintsWithFormat(format: "H:|-20-[v0]-20-|", views: logoutButton)
    }
    
    func goToLogin() {
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
