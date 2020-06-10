//
//  AllPets+DataProviderDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-14.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import UIKit
import SwiftSpinner

extension AllPetsController: DataProviderDelegate {
    func didLoadImage(image: UIImage, reference: UIImageView) {
        let resizedImg = image.circle
        reference.image = resizedImg
        //        SwiftSpinner.hide()
    }
    
    
    func didGetPetData(allPets: [Pet]) {
        pets = allPets
        collectionView.reloadData()
        //        SwiftSpinner.hide()
    }
    
    func didGetPetDataTest() {
        if provider.newPets.count > 1 {
            collectionView.reloadData()
        } else {
            collectionView.performBatchUpdates({
                collectionView.insertItems(at: [IndexPath(item: provider.pets.count - 1, section: 0)])
            }, completion: nil)
            
        }
        
        
    }
    
    func didDeletePet(pet: Pet) {
        for (index, item) in provider.pets.enumerated() {
            if pet.id == item.id {
                collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
                break
            }
        }
    }
}
