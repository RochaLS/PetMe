//
//  Food.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-26.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

class Food {
    
    let brand: String
    let breedSize: String
    let flavour: String
    let imgName: String
    
    init(brand: String, breedSize: String, flavour: String, imgName: String) {
        self.brand = brand
        self.breedSize = breedSize
        self.flavour = flavour
        self.imgName = imgName
    }
}
