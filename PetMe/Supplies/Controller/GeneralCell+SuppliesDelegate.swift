//
//  GeneralCell+SuppliesDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import SwiftSpinner

extension GeneralCell: SuppliesViewControllerDelegate {
    
    func didGetFoodsData(allFoods: [Food]) {
        foods = allFoods
        self.collectionView.reloadData()
    }
    
    func didGetTreatsData(allTreats: [Treat]) {
        treats = allTreats
        self.collectionView.reloadData()
    }
    
    func didGetToysData(allToys: [Toy]) {
        toys = allToys
        self.collectionView.reloadData()
    }
    
    func didLoadImage(image: UIImage, reference: UIImageView) {
        reference.image = image
    }
}
