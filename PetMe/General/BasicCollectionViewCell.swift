//
//  BasicCollectionViewCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-26.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import SwipeCellKit

class BasicCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           backgroundColor = UIColor.white
           layer.cornerRadius = 8
           layer.borderWidth = 0
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowOffset = CGSize(width: 0, height: 1)
           layer.shadowRadius = 2
           layer.shadowOpacity = 0.3
           
           layer.masksToBounds = false //<-
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
