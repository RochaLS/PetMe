//
//  UserDataProvider.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-13.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import FirebaseFirestore

class UserDataProvider {
    let db = Firestore.firestore()
    
    func saveUserData(userID: String, userName: String) {
        db.collection("users").document(userID).setData([
            "name": userName,
            "userID": userID
        ]) { (error) in
            if error != nil {
                print("Error saving user info! \(error!)")
            }
        }
    }
}

