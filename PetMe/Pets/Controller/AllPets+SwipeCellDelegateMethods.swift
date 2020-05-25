//
//  AllPets+SwipeCellDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-05-24.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import SwipeCellKit

extension AllPetsController: SwipeCollectionViewCellDelegate {
    
 func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.provider.deleteSinglePet(pet: self.pets[indexPath.row])
            self.pets.remove(at: indexPath.row)
        }
        
        deleteAction.image = UIImage.fontAwesomeIcon(name: .trash, style: .solid, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
        
        return [deleteAction]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructiveAfterFill
        
        return options
    }
    
    
}
