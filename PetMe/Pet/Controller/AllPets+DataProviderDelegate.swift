//
//  AllPets+DataProviderDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-14.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

extension AllPetsController: DataProviderDelegate {
    
    func didGetPetData(allPets: [Pet]) {
        pets = allPets
        collectionView.reloadData()
    }
    
    
}
