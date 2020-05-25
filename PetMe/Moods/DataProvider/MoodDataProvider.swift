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
        
        let ref = db.collection("moods").order(by: "created_at", descending: true).whereField("petID", isEqualTo: pet.id)
        
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
                let petID = data["petID"] as! String
                
                let mood = Mood(status: status, created_at: date, id: id, petID: petID)
                
                moods.append(mood)
                
            }
            print(moods.count)
            self.delegate?.didLoadMoodData(allMoods: moods)
        }
    }
    
    func addMoodDataToFirestore(moodToAdd mood: Mood, pet: Pet) {
        self.db.collection("moods").document(mood.id).setData([
            "status": mood.status,
            "created_at": mood.created_at,
            "id": mood.id,
            "petID": pet.id
        ]) { (error) in
            if error != nil {
                print("Error when saving: \(error!)")
            } else {
                print("Mood saved")
            }
        }
    }
    
    func deleteMood(mood: Mood) {
        let query = db.collection("moods").document(mood.id)
        
        query.getDocument { (snapshot, error) in
            if error != nil {
                print("Error getting Mood from db! \(error!)")
            } else {
                if let reference = snapshot?.reference {
                    reference.delete { (error) in
                        if error != nil {
                            print("Error deleting mood! \(error!)")
                        } else {
                            print("Mood deleted!")
                        }
                    }
                }
            }
        }
    }
}
