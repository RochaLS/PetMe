//
//  GroupVC+GroupDataProviderDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-06.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import NotificationCenter


extension GroupViewController: GroupDataProviderDelegate {
    func didGetGroupMembers(allMembers: [User]) {
        members = allMembers
        if members.count > 1 {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
        NotificationCenter.default.post(name: .didReceiveMembersData, object: nil , userInfo: ["members": members, "groupID": groupID])
        tableView.reloadData()
    }
    
    func didCheckForOwner(bool: Bool, ownerID: String?) {
        isOwner = bool
        self.ownerID = ownerID
        self.tableView.reloadData()
    }
    
    func didUpdateOwner() {
        self.tableView.reloadData()
    }
}
