//
//  LogoutViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-13.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseInstanceID
import FirebaseMessaging

class SettingsViewController: UIViewController {
    
    weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = AppColors.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 20)!]
        navigationItem.title = "Settings"
        navigationController?.navigationBar.tintColor = UIColor.black
        setupViews()
    }
    
    @objc func signOutUser() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let provider = TokenDataProvider()
            
            if let token = Messaging.messaging().fcmToken {
                provider.deleteTokenFromDB(deviceToken: token)
                InstanceID.instanceID().deleteID { error in
                    if let error = error {
                        print("Error deleting instance ID: \(error)")
                    }
                }
            }
            goToLogin()
            
        } catch let error {
            print(error)
        }
    }
    
    func setupViews() {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView() // Use this to remove extra tableview separators
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        
        
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: tableView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            self.view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            self.view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor)
        ])
        
        self.tableView = tableView
        
    }
    
    func goToLogin() {
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func goToGroup() {
        let controller = GroupViewController()
        controller.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
