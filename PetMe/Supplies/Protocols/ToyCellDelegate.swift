//
//  ToyCellDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

protocol ToyCellDelegate: class {
    func didTapRemove(itemToRemove: Toy)
}
