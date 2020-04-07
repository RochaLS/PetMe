//
//  GroupVC+UserDataProviderDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-06.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

extension GroupViewController: UserDataProviderDelegate {
    
    func didGetUserName(name: String) {
        username = name
    }
    
    func didGetUserGroupID(id: String) {
        groupID = id
        provider.getGroupMembers(groupID: groupID)
    }
    
    
}
