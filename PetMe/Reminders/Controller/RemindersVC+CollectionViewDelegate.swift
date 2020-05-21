//
//  RemindersVC+CollectionViewDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-09.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import SwipeCellKit

extension RemindersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if reminders.count > 0 {
            infoLabel.isHidden = true
        }
        return reminders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_id, for: indexPath) as! ReminderCollectionViewCell
        
        
        cell.delegate = self
        
        
        let reminder = reminders[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        
        cell.titleLabel.text = reminder.title
        cell.createdAtLabel.text = dateFormatter.string(from: reminder.createdAt)
        cell.createdByLabel.text = reminder.createdBy
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           //top, left, bottom, right
           return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
       }
    
    
    
}
