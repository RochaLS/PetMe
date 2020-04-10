//
//  InviteCellDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-08.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

protocol InviteCellDelegate: class {
    
    func didTapAccept(request: Request)
    
    func didTapDecline(request: Request)
    
    
}
