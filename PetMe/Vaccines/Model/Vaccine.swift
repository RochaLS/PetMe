//
//  Vaccine.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-27.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

class Vaccine {
    let name: String
    var taken: Bool = false
    var date: Date?
    var id: String?
    var isCore: Bool
    var pet_id: String?
    
    init(name: String, isCore: Bool) {
        self.name = name
        self.isCore = isCore
    }
}
