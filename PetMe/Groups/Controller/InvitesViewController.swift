//
//  InvitesViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-05.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FirebaseAuth
import PMAlertController
import SwiftSpinner

class InvitesViewController: UIViewController {
    
    weak var tableView: UITableView!
    var requestsProvider: GroupDataProvider! = nil
    var userDataProvider: UserDataProvider! = nil
    let cellID = "InviteCell"
    var requests = [Request]()
    var members = [User]()
    var numOfMembers: Int!
    var tappedRequest: Request!
    var currentUserGroupID: String?
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "You don't have any new invites..."
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        return label
    }()
    
    override func loadView() {
        super.loadView()
        SwiftSpinner.show("Loading", animated: true)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = AppColors.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 20)!]
        navigationItem.title = "Invitations"
        
        setupViews()
        
        userDataProvider = UserDataProvider()
        requestsProvider = GroupDataProvider()
        requestsProvider.delegate = self
        userDataProvider.delegate = self
        
        if let currentUserEmail = Auth.auth().currentUser?.email {
            requestsProvider.getRequests(email: currentUserEmail)
        }
        
        requestsProvider.getGroupMembers(groupID: currentUserGroupID!)
        SwiftSpinner.hide()
        
    }
    
    func setupViews() {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView() // Use this to remove extra tableview separators
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(InvitesTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(infoLabel)
        
        
        
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: tableView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            self.view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            self.view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor)
        ])
        
        self.tableView = tableView
        
        view.addContraintsWithFormat(format: "V:|[v0]|", views: infoLabel)
        view.addContraintsWithFormat(format: "H:|[v0]|", views: infoLabel)
        
    }
    
}
