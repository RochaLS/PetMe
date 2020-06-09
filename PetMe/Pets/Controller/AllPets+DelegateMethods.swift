//
//  AllPets+DelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-06.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//
import UIKit
import FirebaseUI

extension AllPetsController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if provider.pets.count > 0 {
            infoLabel.isHidden = true
        }
        return provider.pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_id , for: indexPath) as! PetCell
        
        cell.index = indexPath.row
        cell.delegate = self
        
        cell.nameLabel.text = provider.pets[indexPath.row].name
        
        cell.petImageView.image = UIImage(named: "placeholder")
        
        if cell.index == indexPath.row {
            cell.petImageView.getImageFromNetworkOrCached(for: provider.pets[indexPath.row])
        }
        
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //top, left, bottom, right
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = PetProfileViewController()
        controller.pet = provider.pets[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @objc func didAddNewPet(notification: Notification) {
        if let data = notification.userInfo as? [String:Pet] {
            
            let newPet = data["newPet"]
            provider.pets.insert(newPet!, at: 0)
            
            
            collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
            
        }
    }
    
}
