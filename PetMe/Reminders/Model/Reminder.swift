//
//  Reminder.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-09.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

class Reminder {
    let title: String
    let id: String
    let createdBy: String
    let createdAt: Date
    
    init(title: String, id: String, createdBy: String, createdAt: Date) {
        self.title = title
        self.id = id
        self.createdBy = createdBy
        self.createdAt = createdAt
    }
}
