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
    
    func didUpdateUserGroupID(userID: String?, groupID: String) {
        NotificationCenter.default.post(name: .didUpdateUserGroupID, object: nil, userInfo: ["groupID":groupID])
    }
}

