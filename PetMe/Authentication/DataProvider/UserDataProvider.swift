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
            "userID": user.userID,
            "groupID": user.groupID
        ]) { (error) in
            if error != nil {
                print("Error saving user info! \(error!)")
            }
        }
    }
    
    func setGroupData(user: User) {
        db.collection("groups").document(user.groupID).setData([
            "users" : [user.userID]
        ]) { (error) in
            if error != nil {
                print("Error setting group data! \(error!)")
            }
        }
    }
    
    func getUserGroupID(userID: String) {
        db.collection("users").document(userID).getDocument { (snapshot, error) in
            guard let data = snapshot?.data() else {
                print("Error geting user data! \(error!)")
                return
            }
            
            
            let currentUserGroupID = data["groupID"] as! String
            self.delegate?.didGetUserGroupID(id: currentUserGroupID )
            
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

