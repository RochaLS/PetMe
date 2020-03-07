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
    weak var delegate: MoodDataProviderDelegate?
    
    func setMoodData(pet: Pet) {
        var moods = [Mood]()
        
        let ref = db.collection("pets").document(pet.id).collection("moods").order(by: "created_at", descending: true)
        
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
                let id = data["id"] as! String
                
                let mood = Mood(status: status, created_at: date, id: id)
                
                moods.append(mood)
                
            }
            self.delegate?.didLoadMoodData(allMoods: moods)
        }
    }
    
    func addMoodDataToFirestore(moodToAdd mood: Mood, pet: Pet) {
        self.db.collection("pets").document(pet.id).collection("moods").document(mood.id).setData([
            "status": mood.status,
            "created_at": mood.created_at,
            "id": mood.id
        ]) { (error) in
            if error != nil {
                print("Error when saving: \(error!)")
            } else {
                print("Mood saved")
            }
        }
    }
}
