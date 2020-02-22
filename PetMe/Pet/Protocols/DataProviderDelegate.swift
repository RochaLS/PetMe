//
//  DataProviderProtocol.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-14.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import UIKit

@objc protocol DataProviderDelegate {
    
    @objc optional func didGetPetData(allPets: [Pet])
    
    func didLoadImage(image: UIImage, reference: UIImageView)
}




