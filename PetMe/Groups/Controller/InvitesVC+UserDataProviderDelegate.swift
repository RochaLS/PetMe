//
//  InvitesVC+UserDataProviderDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-10.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

extension InvitesViewController: UserDataProviderDelegate {
    func didGetUserGroupID(id: String) {
        userDataProvider.checkForNumOfUsersIn(groupID: id)
        currentUserGroupID = id
    }
        
    func didGetNumberOfMembers(num: Int) {
        numOfMembers = num

        showAlert(request: tappedRequest)
        
    }
    
    func gotMostRecentGroupIDData(groupID: String, currentUserID: String) {
        currentUserGroupID = groupID
        requestsProvider.getGroupMembers(groupID: groupID)
    }
    
    func didUpdateUserGroupID(userID: String?, groupID: String) {
        NotificationCenter.default.post(name: .didChangeGroupID, object: nil, userInfo: ["newGroupID": groupID])
    }
    
    
}

