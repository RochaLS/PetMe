//
//  Supplies+TableViewDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-22.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

extension SuppliesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_id, for: indexPath) as! GeneralCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 130)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width // pointee.x is basically the distance of the scroll performed by the the user.
        
        NotificationCenter.default.post(name: .willChangePageTitle, object: nil, userInfo: ["title": titles[Int(index)]])
    }
    
    
    
    
   
    
    
}
