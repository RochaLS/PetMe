//
//  GroupVC+UserDataProviderDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-06.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import FirebaseAuth

extension GroupViewController: UserDataProviderDelegate {
    
    func didGetUserName(name: String) {
        username = name
    }
    
    func didGetUserGroupID(id: String) {
        groupID = id
        provider.getGroupMembers(groupID: groupID)
        
        if let currentUser = Auth.auth().currentUser {
            provider.isUserGroupOwner(userID: currentUser.uid, groupID: id)
        }
         self.tableView.reloadData()
    }
    
    func didUpdateUserGroupID(userID: String?) {
        if let id = userID {
            userDataProvider.getUser(id: id) { (user) in
                print(user.name)
                self.provider.createGroupWithOwner(user: user)
            }
             self.userDataProvider.getUserGroupID(userID: id)
        }
        
//        self.tableView.reloadData()
    }
    
    
    
}
