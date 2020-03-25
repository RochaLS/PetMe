//
//  GeneralDataProvider.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-23.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import FirebaseFirestore

class TokenDataProvider {
    let db = Firestore.firestore()
    
    func saveRegistrationToken(deviceToken: String, userID: String) {
        let ref = db.collection("tokens").document()
        ref.setData([
            "deviceToken" : deviceToken,
            "userID" : userID
        ]) { (error) in
            if error != nil {
                print(error!)
            }
        }
    }
    
    func deleteTokenFromDB(deviceToken: String) {
        let ref = db.collection("tokens").whereField("deviceToken", isEqualTo: deviceToken)
        
        ref.getDocuments { (snapshot, error) in
            
            
            if error != nil {
                print(error!)
            } else {
                if let documents = snapshot?.documents {
                    for document in documents {
                        document.reference.delete()
                    }
                }
            }
            
        }
        
    }
}
