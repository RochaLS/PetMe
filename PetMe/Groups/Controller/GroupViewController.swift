//
//  GroupViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-30.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FirebaseAuth
import PMAlertController
import SwiftSpinner

class GroupViewController: UIViewController {
    
    weak var tableView: UITableView!
    var members = [User]()
    var provider: GroupDataProvider! = nil
    var userDataProvider: UserDataProvider! = nil
    var username = "User"
    var isOwner: Bool!
    var ownerID: String?
    
    
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
    
    let ownerLabel: UILabel = {
        let label = UILabel()
        label.text = "Owner: User"
        label.textColor = UIColor.darkGray
        label.font = AppFonts.mainFontRegular?.withSize(16)
        return label
    }()
    
    override func loadView() {
        super.loadView()
        SwiftSpinner.show("Loading", animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        provider = GroupDataProvider()
        provider.delegate = self
        userDataProvider = UserDataProvider()
        userDataProvider.delegate = self
        
        groupSetup()
        
        self.hideKeyboardWhenTappedAround()
        
        navigationController?.navigationBar.barTintColor = AppColors.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 20)!]
        navigationItem.title = "My Group"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.fontAwesomeIcon(
            name: .doorOpen, style: .solid, textColor: AppColors.black, size: CGSize(width: 30, height: 30)), style: .plain, target: self, action: #selector(leaveGroupButtonPressed))
        
        
        view.backgroundColor = UIColor.white
        setupViews()
        SwiftSpinner.hide()
        
        if let currentUserID = Auth.auth().currentUser?.uid { userDataProvider.getAndObserveUserGroupIDChanges(currentUserID: currentUserID)
        }
        
        
        
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
        view.addSubview(ownerLabel)
        
        
        view.addContraintsWithFormat(format: "V:|-\(self.topbarHeight + 50 + 5)-[v0(50)]-5-[v1]", views: addMemberTextField, ownerLabel)
        view.addContraintsWithFormat(format: "H:|-5-[v0]-10-[v1]-5-|", views: addMemberTextField, sendInviteButton)
        view.addContraintsWithFormat(format: "V:|-\(self.topbarHeight + 50 + 5)-[v0(50)]", views: sendInviteButton)
        view.addContraintsWithFormat(format: "H:|-5-[v0]|", views: ownerLabel)
        
        
        NSLayoutConstraint.activate([
            self.ownerLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -10),
            self.view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            self.view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            self.view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor)
        ])
        
        self.tableView = tableView
        
    }
    
    func groupSetup() {
        if let currentUser = Auth.auth().currentUser {
            userDataProvider.getUserName(userID: currentUser.uid)
            provider.getGroupMembers(groupID: GlobalVariables.currentUserGroupID)
            provider.isUserGroupOwner(userID: currentUser.uid, groupID: GlobalVariables.currentUserGroupID)
            
        }
    }
    
    @objc func sendInviteButtonPressed() {
        let receiverUserInfo = addMemberTextField.text
        if NetworkManager.monitor.currentPath.status == .satisfied {
            if let userID =  Auth.auth().currentUser?.uid {
                if receiverUserInfo ==  Auth.auth().currentUser?.email {
                    Banners.inviteError.show()
                }
                else if receiverUserInfo != nil && receiverUserInfo != "" {
                    let newRequest = Request(receiverUserInfo:receiverUserInfo!.lowercased() , senderID: userID, senderName: username, senderGroupID: GlobalVariables.currentUserGroupID, id: UUID().uuidString)
                    provider.saveInviteRequest(request: newRequest)
                    addMemberTextField.text = ""
                }
            }
        } else {
            Banners.showStatusBanner(on: nil) {
                self.navigationController?.navigationBar.overrideUserInterfaceStyle = .light
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    @objc func leaveGroupButtonPressed() {
        if NetworkManager.monitor.currentPath.status == .satisfied {
            showCustomAlert(title: "Are you sure?", description: "Are you sure you want to leave this group?", image:  UIImage.fontAwesomeIcon(name: .doorOpen, style: .solid, textColor: UIColor.gray, size: CGSize(width: 500, height: 500)))
        } else {
            Banners.showStatusBanner(on: nil) {
                self.navigationController?.navigationBar.overrideUserInterfaceStyle = .light
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
        
    }
    
    func showCustomAlert(title: String, description: String, image: UIImage) {
        let alertVC = PMAlertController(title: title, description: description, image: image, style: .walkthrough)
        
        alertVC.alertTitle.font = AppFonts.mainFontMedium
        alertVC.alertTitle.font = alertVC.alertTitle.font.withSize(22)
        alertVC.alertTitle.textColor = AppColors.black
        
        alertVC.alertDescription.font = AppFonts.mainFontRegular
        alertVC.alertDescription.font = alertVC.alertDescription.font.withSize(18)
        
        
        
        
        
        alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () -> Void in
            print("cancel pressed")
        }))
        
        let confirmAction = PMAlertAction(title: "Confirm", style: .default, action: { () in
            if let currentUser = Auth.auth().currentUser {
                if currentUser.uid == self.ownerID {
                    self.provider.pickNewGroupOwner(currentUserID: currentUser.uid, ownerID: &self.ownerID!, members: self.members, groupID: GlobalVariables.currentUserGroupID)
                }
                self.userDataProvider.updateUserGroupID(groupToDelete: nil, newGroupID: UUID().uuidString, userID: currentUser.uid)
            }
        })
        
        confirmAction.setTitleColor(AppColors.primaryColor, for: .normal)
        
        alertVC.addAction(confirmAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
}
