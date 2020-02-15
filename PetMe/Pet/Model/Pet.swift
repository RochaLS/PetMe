//
//  Pet.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-13.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import UIKit

class Pet {
    
    var name: String
    var age: Int?
//    var imgName: String?
    var img: UIImage // will change that
    var created_at: Date
    
    init(name: String, img: UIImage, created_at: Date) {
        self.name = name
        self.img = img
        self.created_at = created_at
    }
    

}
