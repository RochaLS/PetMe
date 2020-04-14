//
//  GroupCellDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-14.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

protocol GroupCellDelegate: class  {
    
    func didTapRemove(member: User)
}
