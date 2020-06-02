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
            userDataProvider.getUserGroupID(userID: Auth.auth().currentUser!.uid)
        }
    }
    
    func gotMostRecentGroupIDData(groupID: String, currentUserID: String) {
        self.groupID = groupID
        userDataProvider.getUserName(userID: currentUserID)
        provider.getGroupMembers(groupID: groupID)
        provider.isUserGroupOwner(userID: currentUserID, groupID: groupID)
    }
    
    func didGetUserGroupID(id: String) {
        self.groupID = id
        self.provider.getGroupMembers(groupID: id)
    }
}
 
