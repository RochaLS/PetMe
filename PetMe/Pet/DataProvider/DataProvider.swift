//
//  DataProvider.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-14.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import Firebase

class DataProvider {
    
    var db = Firestore.firestore()
    var user_id = ""
    var delegate: DataProviderDelegate?
    
    func setPetData() {
        var pets = [Pet]()
        
        db.collection("pets").getDocuments { (querySnapshot, error) in
            if error != nil {
                print(error!)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    let name = data["name"] as? String
                    let age = data["age"] as? Int
                    let img_name = data["img_name"] as? String
                    
                    let newPet = Pet(name: name!, imgName: img_name!, created_at: Date(), age: age!)
                    pets.append(newPet)
                    
                }
            }
            
            self.delegate?.didGetPetData(allPets: pets)
        }
    }
}
