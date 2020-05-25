//
//  MoodsViewCVDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-21.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

extension MoodsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if moods.count > 0 {
            infoLabel.isHidden = true
        }
        return moods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_id, for: indexPath) as! MoodCollectionViewCell
        
        cell.delegate = self
        
        let mood = moods[indexPath.row]
        cell.moodLabel.text = mood.status
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        cell.datelabel.text = dateFormatter.string(from: mood.created_at)
        cell.timelabel.text = timeFormatter.string(from: mood.created_at)
        
        cell.datelabel.textColor = UIColor.white
        cell.timelabel.textColor = UIColor.white
        cell.moodLabel.textColor = UIColor.white
        
        changeCellBasedOnMoodStatus(mood: mood, cell: cell)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //top, left, bottom, right
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func changeCellBasedOnMoodStatus(mood: Mood, cell: MoodCollectionViewCell) {
        
        switch mood.status {
        case "Happy":
            cell.contentView.backgroundColor = AppColors.orange
        case "Sad":
            cell.contentView.backgroundColor = AppColors.red
        case "Sleepy":
            cell.contentView.backgroundColor = AppColors.babyBlue
        default:
            print("should not get here")
        }
    }
    
}
