//
//  HeaderCollectionReusableView.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-24.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.mainFontMedium?.withSize(20)
        label.textAlignment = .center
        label.textColor = AppColors.black
        return label
    }()
    
    let addButton = DefaultButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(titleLabel)
        addButton.setTitle("Add", for: .normal)
        addSubview(addButton)
        
        addContraintsWithFormat(format: "V:|-20-[v0]-20-|", views: addButton)
        addContraintsWithFormat(format: "V:|[v0]|", views: titleLabel)
        addContraintsWithFormat(format: "H:[v0][v1(80)]-10-|", views: titleLabel, addButton)
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    }
}
