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
            
//            if userID == Auth.auth().currentUser?.uid {
//                self.provider.getGroupMembers(groupID: self.groupID!)
//            } else {
//                self.groupID = groupID
//                self.provider.getGroupMembers(groupID: groupID)
//            }
            
            
            userDataProvider.getUserGroupID(userID: Auth.auth().currentUser!.uid)
         
        }
    }
    
    func didGetUserGroupID(id: String) {
        self.groupID = id
        self.provider.getGroupMembers(groupID: id)
        NotificationCenter.default.post(name: .didUpdateUserGroupID, object: nil, userInfo: ["groupID": id])
    }
}
 
