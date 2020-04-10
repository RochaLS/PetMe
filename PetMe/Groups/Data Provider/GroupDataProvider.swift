//
//  GroupDataProvider.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-31.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import FirebaseFirestore

class GroupDataProvider {
    
    let db = Firestore.firestore()
    weak var delegate: GroupDataProviderDelegate?
    
    
    
    func saveInviteRequest(request: Request) {
        let ref = db.collection("requests")
        
        ref.document(request.id).setData([
            "senderID" :  request.senderID,
            "receiverUserInfo": request.receiverUserInfo,
            "senderName": request.senderName,
            "senderGroupID": request.senderGroupID,
            "requestID": request.id
        ]) { (error) in
            if error != nil {
                print("Error saving Request: \(error!)")
            }
        }
    }
    
    func getRequests(email: String) {
        var requests = [Request]()
        let query = db.collection("requests").whereField("receiverUserInfo", isEqualTo: email)
        
        query.addSnapshotListener() { (snapshot, error) in
            if error != nil {
                print("Error getting requests \(error!)")
            }
            
            
            if let documents = snapshot?.documents {
                
                requests.removeAll()
                
                for document in documents {
                    
                    let data = document.data()
                    
                    let receiverInfo = data["receiverUserInfo"] as! String
                    let senderID = data["senderID"] as! String
                    let senderName = data["senderName"] as! String
                    let senderGroupID = data["senderGroupID"] as! String
                    let requestID = data["requestID"] as! String
                    
                    let request = Request(receiverUserInfo: receiverInfo, senderID: senderID, senderName: senderName, senderGroupID: senderGroupID, id: requestID)
                    
                    requests.append(request)
                    
                }
                self.delegate?.didGetRequests?(allRequests: requests)
            }
        }
    }
    
    func getGroupMembers(groupID: String) {
        var users = [User]()
        let query = db.collection("users").whereField("groupID", isEqualTo: groupID)
        
        query.addSnapshotListener() { (snapshot, error) in
            if error != nil {
                print("Error getting group members: \(error!)")
            }
            
            if let documents = snapshot?.documents {
                users.removeAll()
                for document in documents {
                    let data = document.data()
                    
                    let email = data["email"] as! String
                    let groupID = data["groupID"] as! String
                    let name = data["name"] as! String
                    let userID = data["userID"] as! String
                    
                    let user = User(name: name, userID: userID, groupID: groupID, email: email)
                    users.append(user)
                    
                }
                self.delegate?.didGetGroupMembers?(allMembers: users)
                
            }
        }
    }
    
    func deleteRequest(id: String) {
        db.collection("requests").document(id).delete { (error) in
            if error != nil {
                print("Error deleting request: \(id) - \(error!)")
            }
        }
    }
}
