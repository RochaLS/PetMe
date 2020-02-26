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
    var created_at: Date
    
    init(status: String, created_at: Date) {
        self.status = status
        self.created_at = created_at
    }
}
