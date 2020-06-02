//
//  UserDataProvider.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-13.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserDataProvider {
    let db = Firestore.firestore()
    weak var delegate: UserDataProviderDelegate?
    
    func saveUserData(user: User) {
        db.collection("users").document(user.userID).setData([
            "name": user.name,
            "email": user.email.lowercased(),
            "userID": user.userID,
            "groupID": user.groupID
        ]) { (error) in
            if error != nil {
                print("Error saving user info! \(error!)")
            }
        }
    }
    
    func getUserGroupID(userID: String) {
        db.collection("users").document(userID).getDocument { (snapshot, error) in
            guard let data = snapshot?.data() else {
                return
            }
            
            if error != nil {
                print("Error geting user data! \(error!)")
            }
            
            
            let currentUserGroupID = data["groupID"] as! String
            self.delegate?.didGetUserGroupID?(id: currentUserGroupID)
            
        }
    }
    
    func getUserName(userID: String) {
        db.collection("users").document(userID).getDocument { (snapshot, error) in
            guard let data = snapshot?.data() else {
                return
            }
            
            if error != nil {
                print("Error geting user data! \(error!)")
            }
            
            
            let currentUserName = data["name"] as! String
            self.delegate?.didGetUserName?(name: currentUserName)
            
        }
        
    }
    
    func getUser(id: String, completionHandler: @escaping (_ user: User) -> ()) {
        db.collection("users").document(id).getDocument { (snapshot, error) in
            if error != nil {
                print("Error getting user! \(error!)")
            }
            
            if let data = snapshot?.data() {
                let name = data["name"] as! String
                let id = data["userID"] as! String
                let groupID = data["groupID"] as! String
                let email = data["email"] as! String
                
               let user = User(name: name, userID: id, groupID: groupID, email: email)
                completionHandler(user)
            }
        }
    }
    
    func updateUserGroupID(groupToDelete: String?, newGroupID: String, userID: String) {
        db.collection("users").document(userID).updateData([
            "groupID" : newGroupID
        ]) { (error) in
            if error != nil {
                print("Error updating group id \(error!)")
            } else {
                self.delegate?.didUpdateUserGroupID?(userID: userID, groupID: newGroupID)
            }
        }
        
        if let group = groupToDelete {
            db.collection("groups").document(group).delete { (error) in
                if error != nil {
                    print("Error deleting group! \(error!)")
                }
            }
        }
    }
    
    func checkForNumOfUsersIn(groupID: String) {
        var numOfUsers = 0
        db.collection("users").whereField("groupID", isEqualTo: groupID).getDocuments { (snapshot, error) in
            if error != nil {
                print("Error getting users \(error!)")
            }
            print(groupID)
            if let documents = snapshot?.documents {
                numOfUsers = documents.count
                self.delegate?.didGetNumberOfMembers?(num: numOfUsers)
            }
        }
    }
    
    func getAndObserveUserGroupIDChanges(currentUserID: String) {
        db.collection("users").document(currentUserID).addSnapshotListener { (snapshot, error) in
            
            guard let data = snapshot?.data() else {
                return
            }
            
            if error != nil {
                print(error!)
            } else {
                let groupID = data["groupID"] as! String
                self.delegate?.gotMostRecentGroupIDData?(groupID: groupID, currentUserID: currentUserID)
            }
        }
    }
    
    
    func isLogged() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    
    func goToPets(from vc: UIViewController) {
        let controller = CustomTabBarController()
        controller.modalPresentationStyle = .fullScreen
        vc.present(controller, animated: true, completion: nil)
    }
    
}

