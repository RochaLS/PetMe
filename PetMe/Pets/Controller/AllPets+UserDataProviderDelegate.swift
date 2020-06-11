//
//  AllPets+UserDataProviderDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-17.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import SwiftSpinner

extension AllPetsController: UserDataProviderDelegate {
    
    func gotMostRecentGroupIDData(groupID: String, currentUserID: String) {
        provider.counter = 0
        provider.setPetData(groupID: groupID) // Only get pet data after getting the user group id
        currentUserGroupID = groupID
    }
    
    
}
