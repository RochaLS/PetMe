//
//  RemindersVC+UserDataProviderDlegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-06-17.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

extension RemindersViewController: UserDataProviderDelegate {
    func gotMostRecentGroupIDData(groupID: String, currentUserID: String) {
        GlobalVariables.currentUserGroupID = groupID
        provider.setReminderData(groupID: GlobalVariables.currentUserGroupID)
    }
}
