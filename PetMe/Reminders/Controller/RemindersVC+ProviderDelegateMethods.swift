//
//  RemindersVC+ProviderDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-10.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

extension RemindersViewController: ReminderDataProviderDelegate {
    func setReminderData(allReminders: [Reminder]) {
        reminders = allReminders
        self.collectionView.reloadData()
    }
    
    
}
