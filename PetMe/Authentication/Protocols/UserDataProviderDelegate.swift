//
//  UserDataProviderDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-16.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

@objc protocol UserDataProviderDelegate: class {
    
    @objc optional func didGetUserGroupID(id: String)
    
    @objc optional func didGetUserName(name: String)
    
    @objc optional func didGetNumberOfMembers(num: Int)
    
    @objc optional func didUpdateUserGroupID(userID: String?)
}
