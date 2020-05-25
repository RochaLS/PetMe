//
//  MoodCollectionViewCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-21.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import SwipeCellKit

class MoodCollectionViewCell: SwipeCollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 0
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 0.3
        
        contentView.layer.masksToBounds = false //<-
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let moodLabel: UILabel = {
        let label = UILabel()
        label.text = "Happy"
        label.textColor = AppColors.primaryColor
        label.font = AppFonts.mainFontMedium
        label.font = label.font.withSize(22)
        
        return label
    }()
    
    let timelabel: UILabel = {
        let label = UILabel()
        label.text = "10:54"
        label.textColor = AppColors.black
        
        label.font = AppFonts.mainFontRegular
        label.font = label.font.withSize(16)
        
        return label
    }()
    
    let datelabel: UILabel = {
        let label = UILabel()
        label.text = "01/02/2020"
        label.textColor = AppColors.black
        label.font = AppFonts.mainFontRegular
        label.font = label.font.withSize(16)
        
        return label
    }()
    
    func setupView() {
        
        contentView.addSubview(moodLabel)
        contentView.addSubview(timelabel)
        contentView.addSubview(datelabel)
        
        contentView.addConstraint(NSLayoutConstraint(item: moodLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0))
        
        contentView.addContraintsWithFormat(format: "V:|[v0]|", views: moodLabel)
        contentView.addContraintsWithFormat(format: "V:|-15-[v0]", views: datelabel)
        contentView.addContraintsWithFormat(format: "H:[v0]-15-|", views: datelabel)
        contentView.addContraintsWithFormat(format: "V:|-15-[v0]", views: timelabel)
        contentView.addContraintsWithFormat(format: "H:|-15-[v0]", views: timelabel)
        
        
    }
}
