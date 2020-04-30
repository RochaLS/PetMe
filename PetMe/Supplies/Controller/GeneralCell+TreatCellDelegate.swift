//
//  GeneralCell+TreatCellDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

extension GeneralCell: TreatCellDelegate {
    func didTapRemove(itemToRemove: Treat) {
         NotificationCenter.default.post(name: .willShowAlert , object: nil, userInfo: ["itemToRemove": itemToRemove])
    }
    
    
}
