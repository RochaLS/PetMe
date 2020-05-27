//
//  DataProvider.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-14.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class DataManager {
    
    var db = Firestore.firestore()
    var petsRef: DocumentReference? = nil
    weak var delegate: DataProviderDelegate?
    var storageRef = Storage.storage().reference()
    
    
    
    //MARK: - Get Data
    func setPetData(groupID: String) {
        
        guard let _ = self.delegate?.didGetPetData else {
            return
        }
        
        var pets = [Pet]()
        
        let ref = db.collection("pets").order(by: "created_at", descending: true).whereField("groupID", isEqualTo: groupID)
        
        ref.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            pets.removeAll()
            for document in snapshot.documents {
                print("\(document.documentID) => \(document.data())")
                
                let data = document.data()
                let name = data["name"] as! String
                let age = data["age"] as! Int
                let img_name = data["img_name"] as! String
                let timestamp = data["created_at"] as! Timestamp
                let date = timestamp.dateValue()
                let species = data["species"] as! String
                
                let id = data["id"] as! String
                let groupID = data["groupID"] as! String
                
                let pet = Pet(name: name, imgName: img_name, created_at: date, age: age, id: id, species: species, groupID: groupID )
                
                
                pets.append(pet)
            }
            self.delegate?.didGetPetData!(allPets: pets)
        }
    }
    
    
    //MARK: - Push Data
    
    
    func addPetDataToFirebase(data: Data?, img_name: String, petToAdd pet: Pet) {
        // Just save the data if user doesn't provide me a photo
        if img_name == "placeholder" {
            self.db.collection("pets").document(pet.id).setData([
                "name": pet.name,
                "img_name": pet.imgName!,
                "age": pet.age!,
                "created_at": pet.created_at,
                "id": pet.id,
                "species": pet.species,
                "groupID": pet.groupID
            ]) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added!")
                }
            }
        } else {
            // Only saving the rest of the data after the image is for sure at the storage, to avoid not being to get the image on the collectionView
            let imgRef = storageRef.child("pets/\(img_name)")
            imgRef.putData(data!, metadata: nil) { (metadata, error ) in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    self.db.collection("pets").document(pet.id).setData([
                        "name": pet.name,
                        "img_name": pet.imgName!,
                        "age": pet.age!,
                        "created_at": pet.created_at,
                        "id": pet.id,
                        "species": pet.species,
                        "groupID": pet.groupID
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
    
    func getPetImageToImageView(from pet: Pet, to imageView: UIImageView) {
        let imgRef = storageRef.child("pets/\(pet.imgName!)")
        
        
        imgRef.getData(maxSize: 5 * 1024 * 1024) { (data, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                let img = UIImage(data: data!)
                self.delegate?.didLoadImage(image: img!, reference: imageView)
            }
        }
    }
    
    func deletePets(groupID: String) {
        let query = db.collection("pets").whereField("groupID", isEqualTo: groupID)
        
        
        
        query.getDocuments { (snapshot, error) in
            if error != nil {
                print(error!)
            } else {
                if let documents = snapshot?.documents {
                    for doc in documents {
                        let data = doc.data()
                        let imgName = data["img_name"] as! String
                        
                        doc.reference.delete()
                        self.deleteImage(path: "pets/\(imgName)")
                        
                    }
                }
            }
        }
        
    }
    
    func deleteSinglePet(pet: Pet) {
        let query = db.collection("pets").document("\(pet.id)")
        
        query.getDocument { (snapshot, error) in
            if error == nil {
                if let reference = snapshot?.reference {
                    reference.delete { (error) in
                        if error != nil {
                            print(error!)
                        } else {
                            self.deleteImage(path: "pets/\(pet.imgName!)")
                            print("pet deleted")
                        }
                        
                    }
                }
            } else {
                print("pet not found! \(error!)")
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
