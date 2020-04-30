//
//  Toy.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-26.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

class Toy: Item {
    
    let name: String
    let imgName: String
    let petID: String
    let id: String
    
    init(name: String, imgName: String, petID: String, id: String) {
        self.name = name
        self.imgName = imgName
        self.petID = petID
        self.id = id
    }
}
