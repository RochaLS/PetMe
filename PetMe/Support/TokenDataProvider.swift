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
        
        let query = db.collection("tokens").whereField("userID", isEqualTo: userID)
        let ref = db.collection("tokens").document()
        
        query.getDocuments { (snapshot, error) in
            if error != nil {
                print(error!)
            } else {
                print(snapshot!.documents.count)
                for document in snapshot!.documents {
                    document.reference.delete() // Deleting it to avoid duplicate data on db and then saving below
                }
                
                ref.setData([
                    "deviceToken" : deviceToken,
                    "userID" : userID
                ]) { (error) in
                    if error != nil {
                        print(error!)
                    }
                }
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
