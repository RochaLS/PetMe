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
            self.delegate?.didGetUserGroupID?(id: currentUserGroupID )
            
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
    
    func updateUserGroupID(groupID: String, userID: String) {
        db.collection("users").document(userID).updateData([
            "groupID" : groupID
        ]) { (error) in
            if error != nil {
                print("Error updating group id \(error!)")
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

