//
//  GroupVC+GroupCellDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-14.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import PMAlertController

extension GroupViewController: GroupCellDelegate {
    func didTapRemove(member: User) {
        showAlert(user: member)
    }
    
    private func showAlert(user: User) {
        let alertVC = PMAlertController(title: "Are you sure?", description: "Are you sure you want to remove \(user.name) from your group?", image: UIImage.fontAwesomeIcon(name: .exclamationTriangle, style: .solid, textColor: AppColors.red, size: CGSize(width: 500, height: 500)), style: .walkthrough)
        
        alertVC.alertTitle.font = AppFonts.mainFontMedium
        alertVC.alertTitle.font = alertVC.alertTitle.font.withSize(22)
        alertVC.alertTitle.textColor = AppColors.black
        
        alertVC.alertDescription.font = AppFonts.mainFontRegular
        alertVC.alertDescription.font = alertVC.alertDescription.font.withSize(18)
        
        
        
        
        
        alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () -> Void in
            print("cancel pressed")
        }))
        
        let confirmAction = PMAlertAction(title: "Confirm", style: .default, action: { () in
            self.userDataProvider.updateUserGroupID(groupToDelete: nil, newGroupID: UUID().uuidString, userID: user.userID)
            self.tableView.reloadData()
        })
        
        confirmAction.setTitleColor(AppColors.red, for: .normal)
        
        alertVC.addAction(confirmAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
}
