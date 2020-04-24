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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_id , for: indexPath) as! FavoriteFoodsCollectionViewCell
        cell.setupViews()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 20, height: 120)
    }
    
    
    // For header size (required)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width:collectionView.frame.size.width, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headView", for: indexPath) as! HeaderCollectionReusableView
            
            headView.titleLabel.text = "Favorite Foods"
            return headView
            
        default:
            
            fatalError("Unexpected element kind")
        }
    }
    
    
    
    //    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
    //        view.tintColor = UIColor.white
    //        let header = view as! UITableViewHeaderFooterView
    //        header.textLabel?.textColor = AppColors.black
    //        header.textLabel?.font = AppFonts.mainFontMedium?.withSize(20)
    //        header.addSubview(viewLine2)
    //        header.addContraintsWithFormat(format: "V:[v0]|", views: viewLine2)
    //        header.addContraintsWithFormat(format: "H:|-10-[v0(2)]-10-|", views: viewLine2)
    //    }
    
    
}
