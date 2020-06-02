//
//  SettingsVC+UserDataProviderDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-05-27.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

extension SettingsViewController: UserDataProviderDelegate {
    
    func didGetUserGroupID(id: String) {
        self.currentUserGroupID = id
        print(currentUserGroupID!)
    }
}
