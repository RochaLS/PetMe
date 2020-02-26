//
//  MoodProvider.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-25.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import Firebase

class MoodDataProvider {
    var db = Firestore.firestore()
    var petsRef: DocumentReference? = nil
    var delegate: MoodDataProviderDelegate?
    
    func setMoodData(pet: Pet) {
        var moods = [Mood]()
        
        let ref = db.collection("pets").document(pet.id).collection("moods")
        
        ref.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            moods.removeAll()
            
            for document in snapshot.documents {
                print("\(document.documentID) => \(document.data())")
                
                let data = document.data()
                let status = data["status"] as! String
                let timeStamp = data["created_at"] as! Timestamp
                let date = timeStamp.dateValue()
                
                let mood = Mood(status: status, created_at: date)
                
                moods.append(mood)
                
            }
            self.delegate?.didLoadMoodData(allMoods: moods)
        }
    }
}
