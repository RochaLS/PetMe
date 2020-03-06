//
//  VaccineDataProviderDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-28.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

protocol VaccinesDataProviderDelegate {
    
    func didGetVaccinesData(allVaccines: [Vaccine])
    
    
}
