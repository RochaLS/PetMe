//
//  ReminderCollectionViewCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-09.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import SwipeCellKit

class ReminderCollectionViewCell: SwipeCollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 8
         contentView.layer.borderWidth = 0
         contentView.layer.shadowColor = UIColor.black.cgColor
         contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
         contentView.layer.shadowRadius = 2
         contentView.layer.shadowOpacity = 0.3
        
        layer.masksToBounds = false //<-
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Buy Food"
        label.numberOfLines = 0
        label.textColor = AppColors.black
        label.font = AppFonts.mainFontRegular
        return label
    }()
    
    let createdByLabel: UILabel = {
        let label = UILabel()
        label.text = "Gabriel"
        label.numberOfLines = 0
        label.textColor = AppColors.primaryColor
        label.font = AppFonts.mainFontRegular
        label.font = label.font.withSize(17)
        return label
    }()
    
    let createdAtLabel: UILabel = {
        let label = UILabel()
        label.text = "20/10/20"
        label.numberOfLines = 0
        label.textColor = UIColor.gray
        label.font = AppFonts.mainFontRegular
        label.font = label.font.withSize(17)
        return label
    }()
    
    func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(createdByLabel)
        contentView.addSubview(createdAtLabel)
        contentView.addContraintsWithFormat(format: "V:|[v0]|", views: titleLabel)
        contentView.addContraintsWithFormat(format: "H:|-15-[v0]-15-|", views: titleLabel)
        contentView.addContraintsWithFormat(format: "V:|-10-[v0]", views: createdAtLabel)
        contentView.addContraintsWithFormat(format: "H:[v0]-15-|", views: createdAtLabel)
        contentView.addContraintsWithFormat(format: "V:|-10-[v0]", views: createdByLabel)
        contentView.addContraintsWithFormat(format: "H:|-15-[v0]", views: createdByLabel)
    }
}
