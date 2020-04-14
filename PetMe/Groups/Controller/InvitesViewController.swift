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

class InvitesViewController: UIViewController {
    
    weak var tableView: UITableView!
    var requestsProvider: GroupDataProvider! = nil
    var userDataProvider: UserDataProvider! = nil
    let cellID = "InviteCell"
    var requests = [Request]()
    var numOfMembers: Int!
    var tappedRequest: Request!
    var currentUserGroupID: String?
    
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
    }
    
    func setupViews() {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView() // Use this to remove extra tableview separators
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(InvitesTableViewCell.self, forCellReuseIdentifier: cellID)
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
    
    func showUserAlert(request: Request) {
        let alertVC = PMAlertController(title: "Are you sure?", description: "If you join this group all your data will replaced by the new group's data. This includes pets, vaccinations and reminders.", image: UIImage.fontAwesomeIcon(name: .exclamationTriangle, style: .solid, textColor: AppColors.red, size: CGSize(width: 500, height: 500)), style: .walkthrough)
        
        alertVC.alertTitle.font = AppFonts.mainFontMedium
        alertVC.alertTitle.font = alertVC.alertTitle.font.withSize(22)
        alertVC.alertTitle.textColor = AppColors.black
        
        alertVC.alertDescription.font = AppFonts.mainFontRegular
        alertVC.alertDescription.font = alertVC.alertDescription.font.withSize(18)
        
        
        
        
        
        alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () -> Void in
            print("cancel pressed")
        }))
        
        
        let confirmAction = PMAlertAction(title: "Comfirm", style: .default, action: { () in
            self.userDataProvider.updateUserGroupID(groupID: request.senderGroupID, userID: Auth.auth().currentUser!.uid)
            self.requestsProvider.deleteRequest(id: request.id)
        })
        
        confirmAction.setTitleColor(AppColors.primaryColor, for: .normal)
        
        alertVC.addAction(confirmAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
}
