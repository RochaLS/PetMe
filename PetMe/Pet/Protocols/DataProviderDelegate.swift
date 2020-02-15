//
//  DataProviderProtocol.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-14.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

protocol DataProviderDelegate {
    
    func didGetPetData(allPets: [Pet])
}
