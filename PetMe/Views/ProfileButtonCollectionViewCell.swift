//
//  ProfileButtonCollectionViewCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-07.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FontAwesome_swift

class ProfileButtonCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.cornerRadius = 5
        layer.borderWidth = 0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false //<-
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let optionName: UILabel = {
        let label = UILabel()
        label.text = "Option"
        label.textColor = AppColors.primaryColor
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        return label
        
    }()
    
    func setupViews() {
        addSubview(optionName)
        
        addContraintsWithFormat(format: "V:|[v0]|" , views: optionName)
        addContraintsWithFormat(format: "H:|[v0]|" , views: optionName)
        
    }
    
}
