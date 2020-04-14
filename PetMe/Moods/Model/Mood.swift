//
//  Moods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-25.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

class Mood {
    var status: String
    let created_at: Date
    let id: String
    let petID: String
    
    init(status: String, created_at: Date, id : String, petID: String) {
        self.status = status
        self.created_at = created_at
        self.id = id
        self.petID = petID
    }
}
