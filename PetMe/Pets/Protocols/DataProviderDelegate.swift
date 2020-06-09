//
//  DataProviderProtocol.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-14.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import UIKit

@objc protocol DataProviderDelegate: class {
    
    @objc optional func didGetPetData(allPets: [Pet])
    
    @objc optional func didGetPetDataTest()
    
    @objc optional func didAddNewPet(pet: Pet)
    
    func didLoadImage(image: UIImage, reference: UIImageView)
}




