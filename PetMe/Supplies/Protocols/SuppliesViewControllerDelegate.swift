//
//  SuppliesViewControllerDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

protocol SuppliesViewControllerDelegate: class {
    
    func didGetFoodsData(allFoods: [Food])
    
    func didGetTreatsData(allTreats: [Treat])
    
    func didGetToysData(allToys: [Toy])
   
}
