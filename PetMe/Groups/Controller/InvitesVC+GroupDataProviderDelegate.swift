//
//  InvitesVC+GroupDataProviderDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-06.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import FirebaseAuth

extension InvitesViewController: GroupDataProviderDelegate {
    func didGetRequests(allRequests: [Request]) {
        requests = allRequests
        tableView.reloadData()
    }
    
    func didCheckForOwner(bool: Bool, ownerID: String?) {
        if let id = Auth.auth().currentUser?.uid {
            if bool == true {
                var owner_ID = ownerID!
                requestsProvider.pickNewGroupOwner(currentUserID: id, ownerID: &owner_ID, members: self.members, groupID: currentUserGroupID!)
            }
        }
    }
    
    func didGetGroupMembers(allMembers: [User]) {
        members = allMembers
    }
    
}
