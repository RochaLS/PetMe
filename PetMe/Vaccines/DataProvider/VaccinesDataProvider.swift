//
//  VaccinationsDataProvider.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-28.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import Firebase

class VaccinesDataProvider {
    let db = Firestore.firestore()
    var delegate: VaccinesDataProviderDelegate?
    
    func setVaccineData(petID: String) {
        let ref = db.collection("vaccines").whereField("pet_id", isEqualTo: petID)
        var vaccines = [Vaccine]()
        
        ref.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            vaccines.removeAll()
            
            for document in snapshot.documents {
                print("\(document.documentID) => \(document.data())")
                
                let data = document.data()
                let name = data["name"] as! String
                let taken = data["taken"] as! Bool
                let isCore = data["isCore"] as! Bool
                let id = data["id"] as! String
                let pet_id = data["pet_id"] as! String
                
                let vaccine = Vaccine(name: name, isCore: isCore)
                vaccine.taken = taken
                vaccine.id = id
                vaccine.pet_id = pet_id
                vaccines.append(vaccine)
            }
            self.delegate?.didGetVaccinesData(allVaccines: vaccines)
            
        }
    }
    
    func addDataToFirestore(vaccines: [Vaccine]) {
        for vaccine in vaccines {
            let ref = db.collection("vaccines").document(vaccine.id!)
            ref.setData([
                "name" : vaccine.name,
                "taken": vaccine.taken,
                "id": vaccine.id!,
                "isCore": vaccine.isCore,
                "pet_id": vaccine.pet_id!
            ]) { (error) in
                if error != nil {
                    print("error saving vaccine info: \(error!)")
                } else {
                    print("Vaccines added to pet: \(vaccine.pet_id!)")
                }
                
            }
        }
    }
}
