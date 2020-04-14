//
//  GroupDataProviderDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-06.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

@objc protocol GroupDataProviderDelegate: class {
    
    @objc optional func didGetRequests(allRequests: [Request])
    
    @objc optional func didGetGroupMembers(allMembers: [User])
    
    @objc optional func didCheckForOwner(bool: Bool) 
}
