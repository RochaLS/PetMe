//
//  InvitesVC+UserDataProviderDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-10.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import FirebaseAuth

extension InvitesViewController: UserDataProviderDelegate {
    func didGetNumberOfMembers(num: Int) {
        numOfMembers = num

        showAlert(request: tappedRequest)
        
    }
    
    func didUpdateUserGroupID(userID: String?, groupID: String) {
        if userID == Auth.auth().currentUser?.uid {
            GlobalVariables.currentUserGroupID = groupID
        }
//        NotificationCenter.default.post(name: .didChangeGroupID, object: nil, userInfo: ["newGroupID": groupID])
    }
    
    
}

