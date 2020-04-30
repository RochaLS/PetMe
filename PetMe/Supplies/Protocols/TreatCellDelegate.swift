//
//  TreatCellDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

protocol TreatCellDelegate: class {
    func didTapRemove(itemToRemove: Treat)
}
