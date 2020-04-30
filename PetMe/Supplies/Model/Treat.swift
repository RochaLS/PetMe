//
//  Treat.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-26.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

class Treat: Item {
    
    let name: String
    let brand: String
    let imgName: String
    let id: String
    let petID: String
    
    init(name: String, brand: String, imgName: String, petID: String, id: String) {
        self.name = name
        self.brand = brand
        self.imgName = imgName
        self.petID = petID
        self.id = id
    }
}
