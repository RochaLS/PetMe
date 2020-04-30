//
//  RemindersVC+UserDataProviderDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-17.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import SwiftSpinner

extension RemindersViewController: UserDataProviderDelegate {
    func didGetUserGroupID(id: String) {
//        SwiftSpinner.show("Loading", animated: true)
        provider.setReminderData(groupID: id) // Same flow as the pet one, first get user group ID and after show reminders
        currentUserGroupID = id
    }
    
    
}
