//
//  ReminderDataProvider.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-10.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Firebase

class ReminderDataProvider {
    var db = Firestore.firestore()
    var delegate: ReminderDataProviderDelegate?
    
    func setReminderData() {
        
        let ref = db.collection("reminders").order(by: "createdAt", descending: true)
        var reminders = [Reminder]()
        
        ref.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            reminders.removeAll()
            
            for document in snapshot.documents {
                let data = document.data()
                let title = data["title"] as! String
                let id = data["id"] as! String
                let createdBy = data["createdBy"] as! String
                let timestamp = data["createdAt"] as! Timestamp
                let createdAt = timestamp.dateValue()
                
                let reminder = Reminder(title: title, id: id, createdBy: createdBy, createdAt: createdAt)
                reminders.append(reminder)
                self.delegate?.setReminderData(allReminders: reminders)
            }
        }
    }
    
    func addReminderDataToFirestore(reminder: Reminder) {
        db.collection("reminders").document(reminder.id).setData([
            "title" : reminder.title,
            "id" : reminder.id,
            "createdBy" : reminder.createdBy, //Will use user ID in the future instead of the name when saving in DB
            "createdAt" : reminder.createdAt
        ]) { (error) in
            if error != nil {
                print("Couldn't save data! Error: \(error!)")
            }
        }
    }
    
    func deleteData(reminder: Reminder) {
        db.collection("reminders").document(reminder.id).delete { (error) in
            if error != nil {
                print("Couldn't delete data! Error: \(error!)")
            }
        }
    }
    
    
}
