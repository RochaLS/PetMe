//
//  InvitesVC+InviteCellDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-08.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import FirebaseAuth
import PMAlertController

extension InvitesViewController: InviteCellDelegate {
    
    func didTapAccept(request: Request) {
        userDataProvider.checkForNumOfUsersIn(groupID: GlobalVariables.currentUserGroupID)
    }
    
    func didTapDecline(request: Request) {
        requestsProvider.deleteRequest(id: request.id)
        
    }
    
    func showAlert(request: Request) {
        if let currentUser = Auth.auth().currentUser {
            
            
            let alertVC = PMAlertController(title: "Are you sure?", description: "If you join \(request.senderName)'s group all your data will replaced by the new group's data. This includes pets, vaccinations and reminders.", image: UIImage.fontAwesomeIcon(name: .exclamationTriangle, style: .solid, textColor: AppColors.red, size: CGSize(width: 500, height: 500)), style: .walkthrough)
            
            alertVC.alertTitle.font = AppFonts.mainFontMedium
            alertVC.alertTitle.font = alertVC.alertTitle.font.withSize(22)
            alertVC.alertTitle.textColor = AppColors.black
            
            alertVC.alertDescription.font = AppFonts.mainFontRegular
            alertVC.alertDescription.font = alertVC.alertDescription.font.withSize(18)
            
            
            
            
            
            alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () -> Void in
                print("cancel pressed")
            }))
            
            let confirmAction = PMAlertAction(title: "Confirm", style: .default, action: { () in
                
                self.requestsProvider.isUserGroupOwner(userID: currentUser.uid, groupID: GlobalVariables.currentUserGroupID)
                
                let petDataProvider = DataManager()
                
                
                if self.numOfMembers == 1 {
                    petDataProvider.deletePets(groupID: GlobalVariables.currentUserGroupID)
                    self.userDataProvider.updateUserGroupID(groupToDelete: GlobalVariables.currentUserGroupID, newGroupID: request.senderGroupID, userID: currentUser.uid)
                } else {
                    self.userDataProvider.updateUserGroupID(groupToDelete: nil, newGroupID: request.senderGroupID, userID: currentUser.uid)
                }
                
                
                self.requestsProvider.deleteRequest(id: request.id)
            })
            
            confirmAction.setTitleColor(AppColors.red, for: .normal)
            
            alertVC.addAction(confirmAction)
            
            self.present(alertVC, animated: true, completion: nil)
            
            
        }
    }
    
    
}
