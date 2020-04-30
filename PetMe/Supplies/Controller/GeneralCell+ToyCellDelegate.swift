//
//  GeneralCell+ToyCellDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

extension GeneralCell: ToyCellDelegate {
    func didTapRemove(itemToRemove: Toy) {
         NotificationCenter.default.post(name: .willShowAlert , object: nil, userInfo: ["itemToRemove": itemToRemove])
    }
}
