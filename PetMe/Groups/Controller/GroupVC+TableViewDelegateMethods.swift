//
//  GroupVC+TableViewDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-30.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FirebaseAuth

extension GroupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupTableViewCell
        
        if let currentUser = Auth.auth().currentUser {
            if isOwner == false {
                cell.deleteButton.isHidden = true
                cell.deleteButton.isEnabled = false
            } else if isOwner == true && members[indexPath.row].userID == currentUser.uid {
                cell.deleteButton.isHidden = true
                cell.deleteButton.isEnabled = false
            } else {
                cell.deleteButton.isHidden = false
                cell.deleteButton.isEnabled = true
            }
        }
        
        cell.nameLabel.text = members[indexPath.row].name
        cell.selectionStyle = .none
        cell.setupView()
        cell.delegate = self
        cell.setupMember(member: members[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    
}
