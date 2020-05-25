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
    weak var delegate: SuppliesViewControllerDelegate?
    
    
    func getFoodData(petID: String) {
        let ref = db.collection("foods").whereField("petID", isEqualTo: petID)
        
        var foods = [Food]()
        ref.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            foods.removeAll()
            for document in snapshot.documents {
                print("\(document.documentID) => \(document.data())")
                
                let data = document.data()
                
                let brand = data["brand"] as! String
                let breedSize = data["breedSize"] as! String
                let flavour = data["flavour"] as! String
                let imgName = data["imgName"] as! String
                let type = data["type"] as! String
                let id = data["id"] as! String
                let petID = data["petID"] as! String
                
                let food = Food(brand: brand, breedSize: breedSize, flavour: flavour, type: type, imgName: imgName , id: id, petID: petID)
                
                foods.append(food)
                
            }
            self.delegate?.didGetFoodsData(allFoods: foods)
        }
    }
    
    func getTreatData(petID: String) {
        let ref = db.collection("treats").whereField("petID", isEqualTo: petID)
        
        var treats = [Treat]()
        ref.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            treats.removeAll()
            for document in snapshot.documents {
                print("\(document.documentID) => \(document.data())")
                
                let data = document.data()
                
                let brand = data["brand"] as! String
                let name = data["name"] as! String
                let imgName = data["imgName"] as! String
                let id = data["id"] as! String
                let petID = data["petID"] as! String
                
                let treat = Treat(name: name, brand: brand, imgName: imgName, petID: petID, id: id)
                
                treats.append(treat)
                
            }
            self.delegate?.didGetTreatsData(allTreats: treats)
        }
    }
    
    func getToyData(petID: String) {
        let ref = db.collection("toys").whereField("petID", isEqualTo: petID)
        
        var toys = [Toy]()
        ref.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            toys.removeAll()
            for document in snapshot.documents {
                print("\(document.documentID) => \(document.data())")
                
                let data = document.data()
                
                let name = data["name"] as! String
                let imgName = data["imgName"] as! String
                let id = data["id"] as! String
                let petID = data["petID"] as! String
                
                let toy = Toy(name: name, imgName: imgName, petID: petID, id: id)
                
                toys.append(toy)
                
            }
            self.delegate?.didGetToysData(allToys: toys)
        }
    }
    
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
                    "type": food.type,
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
    
    func getSupplyImage(of imgName: String, to imageView: UIImageView, typeOfSupply: String) {
        let imgRef = storageRef.child("\(typeOfSupply)/\(imgName)")
        
        
        imgRef.getData(maxSize: 5 * 1024 * 1024) { (data, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                let img = UIImage(data: data!)
                self.delegate?.didLoadImage(image: img!, reference: imageView)
            }
        }
    }
    
    func deleteFood(food: Food) {
        let query = db.collection("foods").whereField("id", isEqualTo: food.id)
        
        query.getDocuments { (querySnapshot, error) in
            if error != nil {
                print(error!)
            } else {
                if let snapshot = querySnapshot {
                    for doc in snapshot.documents {
                        doc.reference.delete()
                        self.deleteImage(path: "foods\(food.imgName)")
                    }
                }
            }
        }
    }
    
    func deleteTreat(treat: Treat) {
        let query = db.collection("treats").whereField("id", isEqualTo: treat.id)
        
        query.getDocuments { (querySnapshot, error) in
            if error != nil {
                print(error!)
            } else {
                if let snapshot = querySnapshot {
                    for doc in snapshot.documents {
                        doc.reference.delete()
                        self.deleteImage(path: "treats/\(treat.imgName)")
                    }
                }
            }
        }
    }
    
    func deleteToy(toy: Toy) {
        let query = db.collection("toys").whereField("id", isEqualTo: toy.id)
        
        query.getDocuments { (querySnapshot, error) in
            if error != nil {
                print(error!)
            } else {
                if let snapshot = querySnapshot {
                    for doc in snapshot.documents {
                        doc.reference.delete()
                        self.deleteImage(path: "toys/\(toy.imgName)")
                    }
                }
            }
        }
    }
    
    func deleteImage(path: String) {
        let imgRef = storageRef.child(path)
        imgRef.delete { (error) in
            if error != nil {
                print("Error deleting image! \(error!)")
            } else {
                print("Image deleted")
            }
        }
    }
}
