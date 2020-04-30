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
    func didGetUserGroupID(id: String) {
//         SwiftSpinner.show("Loading", animated: true)
        provider.setPetData(groupID: id) // Only get pet data after getting the user group id
        currentUserGroupID = id
    }
    
    
}
