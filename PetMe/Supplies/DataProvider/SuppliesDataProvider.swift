//
//  SuppliesDataProvider.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-28.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import Firebase

class SuppliesDataProvider {
    
    let db = Firestore.firestore()
    var storageRef = Storage.storage().reference()
    
    func saveFoodData(petID: String, imgData: Data?, imgName: String, food: Food) {
        let imgRef = storageRef.child("foods/\(imgName)")
        imgRef.putData(imgData!, metadata: nil) { (metadata, error ) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.db.collection("foods").document(food.id).setData([
                    "brand": food.brand,
                    "breedSize": food.breedSize,
                    "flavour": food.flavour,
                    "id": food.id,
                    "petID": petID,
                    "imgName": food.imgName
                ]) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        print("Document added")
                    }
                }
            }
        }
    }
    
    func saveTreatData(petID: String, imgData: Data?, imgName: String, treat: Treat) {
        let imgRef = storageRef.child("treats/\(imgName)")
        imgRef.putData(imgData!, metadata: nil) { (metadata, error ) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.db.collection("treats").document(treat.id).setData([
                    "brand": treat.brand,
                    "name": treat.name,
                    "id": treat.id,
                    "petID": petID,
                    "imgName": treat.imgName
                ]) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        print("Document added")
                    }
                }
            }
        }
    }
    
    func saveToyData(petID: String, imgData: Data?, imgName: String, toy: Toy) {
        let imgRef = storageRef.child("toys/\(imgName)")
        imgRef.putData(imgData!, metadata: nil) { (metadata, error ) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.db.collection("toys").document(toy.id).setData([
                    "name": toy.name,
                    "id": toy.id,
                    "petID": petID,
                    "imgName": toy.imgName
                ]) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        print("Document added")
                    }
                }
            }
        }
    }
}
