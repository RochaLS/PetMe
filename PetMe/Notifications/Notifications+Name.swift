//
//  Notifications+Name.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-17.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let didReceiveMembersData = Notification.Name("didReceiveMembersData")
    static let willChangePageTitle = Notification.Name("willChangePageTitle")
    static let didTapOnAdd = Notification.Name("didTapOnAdd")
    static let willPassPetID = Notification.Name("willPassPetID")
}
