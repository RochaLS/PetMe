//
//  UserDataProviderDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-16.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

protocol UserDataProviderDelegate: class {
    
    func didGetUserGroupID(id: String)
}
