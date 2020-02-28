//
//  Pet.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-13.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import UIKit

class Pet: NSObject {
    
    var name: String
    var age: Int?
    var imgName: String?
    var created_at: Date
    var id: String
    var species: String
    var vaccines: [String:[Vaccine]]?
    
    init(name: String, imgName: String, created_at: Date, age: Int?, id: String, species: String) {
        self.name = name
        self.imgName = imgName
        self.created_at = created_at
        self.age = age
        self.id = id
        self.species = species
    }
    

}
