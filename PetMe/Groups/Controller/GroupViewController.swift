//
//  GroupViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-30.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FirebaseAuth

class GroupViewController: UIViewController {
    
    weak var tableView: UITableView!
    var members = [User]()
    var provider: GroupDataProvider! = nil
    var userDataProvider: UserDataProvider! = nil
    var username = "User"
    var groupID = "id"
    
    let addMemberTextField: UITextField = {
        let textField = DefaultTextField()
        textField.placeholder = "User's Email"
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let sendInviteButton: UIButton = {
        let button = DefaultButton()
        button.setTitle("Send Invite", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.addTarget(self, action: #selector(sendInviteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        provider = GroupDataProvider()
        provider.delegate = self
        userDataProvider = UserDataProvider()
        userDataProvider.delegate = self
        
        if let currentUser = Auth.auth().currentUser {
            userDataProvider.getUserName(userID: currentUser.uid)
            userDataProvider.getUserGroupID(userID: currentUser.uid)
        }
        self.hideKeyboardWhenTappedAround()
        
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = AppColors.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 20)!]
        navigationItem.title = "My Group"
        view.backgroundColor = UIColor.white
        print(groupID)
        setupViews()
    }
    
    
    func setupViews() {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView() // Use this to remove extra tableview separators
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "GroupCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(addMemberTextField)
        view.addSubview(sendInviteButton)
        
        
        view.addContraintsWithFormat(format: "V:|-\(self.topbarHeight + 50 + 5)-[v0(50)]", views: addMemberTextField)
        view.addContraintsWithFormat(format: "H:|-5-[v0]-10-[v1]-5-|", views: addMemberTextField, sendInviteButton)
        view.addContraintsWithFormat(format: "V:|-\(self.topbarHeight + 50 + 5)-[v0(50)]", views: sendInviteButton)
        
        
        
        NSLayoutConstraint.activate([
            self.addMemberTextField.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -10),
            self.view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            self.view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            self.view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor)
        ])
        
        self.tableView = tableView
        
    }
    
    @objc func sendInviteButtonPressed() {
        let receiverUserInfo = addMemberTextField.text
        if let userID =  Auth.auth().currentUser?.uid {
            if receiverUserInfo != nil && receiverUserInfo != "" {
                let newRequest = Request(receiverUserInfo:receiverUserInfo!.lowercased() , senderID: userID, senderName: username, senderGroupID: groupID, id: UUID().uuidString)
                provider.saveInviteRequest(request: newRequest)
                addMemberTextField.text = ""
            }
        }
    }
    
}
