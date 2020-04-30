//
//  GeneralCell+FoodCellDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import PMAlertController

extension GeneralCell: FoodCellDelegate {
    func didTapRemove(itemToRemove: Food) {
        NotificationCenter.default.post(name: .willShowAlert , object: nil, userInfo: ["itemToRemove": itemToRemove])
    }
    
}
