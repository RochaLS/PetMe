//
//  MoodsVC+SwipeCellDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-05-24.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import SwipeCellKit

extension MoodsViewController: SwipeCollectionViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.provider.deleteMood(mood: self.moods[indexPath.row])
            self.moods.remove(at: indexPath.row)
        }
        
        
        deleteAction.backgroundColor = UIColor.white
        deleteAction.textColor =  UIColor.red
        deleteAction.image = UIImage.fontAwesomeIcon(name: .trash, style: .solid, textColor: UIColor.red, size: CGSize(width: 30, height: 30))
        
        return [deleteAction]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.backgroundColor = UIColor.white
        options.expansionStyle = .destructiveAfterFill
        
        return options
    }
}
