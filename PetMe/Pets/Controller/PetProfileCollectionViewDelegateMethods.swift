//
//  PetProfileCollectionViewDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-07.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FontAwesome_swift

extension PetProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_id , for: indexPath) as! ProfileButtonCollectionViewCell
        
        
        if indexPath.row == 0 {
            cell.optionName.attributedText = createStringWithIcon(word: "Vaccination", fontAwesomeIconToAppend: String.fontAwesomeIcon(name: .syringe))
        } else if indexPath.row == 1 {
            cell.optionName.attributedText = createStringWithIcon(word: "Supplies", fontAwesomeIconToAppend: String.fontAwesomeIcon(name: .bone))
        } else if indexPath.row == 2 {
            cell.optionName.attributedText = createStringWithIcon(word: "Mood", fontAwesomeIconToAppend: String.fontAwesomeIcon(name: .paw))
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 60, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    
    //This function only works with solid fontAwesome icons
    func createStringWithIcon(word: String, fontAwesomeIconToAppend: String) -> NSMutableAttributedString {
        let string =  NSMutableAttributedString(string: "\(fontAwesomeIconToAppend) ", attributes:         [.font: UIFont.fontAwesome(ofSize: 24, style: .solid)]  )
        
        string.append(NSAttributedString(string: word, attributes: [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 22)!, NSAttributedString.Key.foregroundColor: AppColors.black]
        ))
        
        return string
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let controller = VaccinesViewController()
            controller.pet = pet
            navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 1 {
            let controller = SuppliesViewController()
            controller.pet = pet
            controller.avatarRawImage = avatarRawImage
            navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 2 {
            let controller = MoodsViewController()
            controller.pet = pet
            navigationController?.pushViewController(controller, animated: true)
        }
        
    }
}
