//
//  Request.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-06.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

class Request: NSObject {
    let receiverUserInfo: String
    let senderID: String
    let senderName: String
    
    init(receiverUserInfo: String, senderID: String, senderName: String) {
        self.receiverUserInfo = receiverUserInfo
        self.senderID = senderID
        self.senderName = senderName
    }
}
