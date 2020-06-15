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
    
    func didUpdateUserGroupID(userID: String?, groupID: String) {
        
        if let id = userID {
            userDataProvider.getUser(id: id) { (user) in
                print(user.name)
                self.provider.createGroupWithOwner(user: user)
            }
            
            if id == Auth.auth().currentUser?.uid {
                GlobalVariables.currentUserGroupID = groupID
                provider.getGroupMembers(groupID: GlobalVariables.currentUserGroupID)
                NotificationCenter.default.post(name: .didChangeGroupID, object: nil, userInfo: nil)
            } else {
                tableView.reloadData()
            }
        }
    }
    
    func gotMostRecentGroupIDData(groupID: String, currentUserID: String) {
        GlobalVariables.currentUserGroupID = groupID
        provider.getGroupMembers(groupID: GlobalVariables.currentUserGroupID)
        NotificationCenter.default.post(name: .didChangeGroupID, object: nil, userInfo: nil)
    }
    
}
 
