//
//  GroupDataProvider.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-31.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import FirebaseFirestore

class GroupDataProvider {
    
    let db = Firestore.firestore()
    
    
    func saveInviteRequest(receiverUserInfo: String, senderUserID: String) {
        let ref = db.collection("requests")
        
        ref.document().setData([
            "senderID" :  senderUserID,
            "receiverUserInfo": receiverUserInfo
        ]) { (error) in
            if error != nil {
                print("Error saving Request: \(error!)")
            }
        }
    }
}
