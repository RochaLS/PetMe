//
//  MoodCollectionViewCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-21.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class MoodCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let moodLabel: UILabel = {
        let label = UILabel()
        label.text = "Happy"
        label.textColor = AppColors.primaryColor
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        return label
    }()
    
    let timelabel: UILabel = {
        let label = UILabel()
        label.text = "10:54"
        label.textColor = AppColors.black
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        
        return label
    }()
    
    let datelabel: UILabel = {
        let label = UILabel()
        label.text = "01/02/2020"
        label.textColor = AppColors.black
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        
        return label
    }()
    
    func setupView() {
    
        addSubview(moodLabel)
        addSubview(timelabel)
        addSubview(datelabel)
        
        addConstraint(NSLayoutConstraint(item: moodLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addContraintsWithFormat(format: "V:|[v0]|", views: moodLabel)
        addContraintsWithFormat(format: "V:|-15-[v0]", views: datelabel)
        addContraintsWithFormat(format: "H:[v0]-15-|", views: datelabel)
        addContraintsWithFormat(format: "V:|-15-[v0]", views: timelabel)
        addContraintsWithFormat(format: "H:|-15-[v0]", views: timelabel)
        
        
         backgroundColor = UIColor.white
         layer.cornerRadius = 20
         layer.borderWidth = 0
         layer.shadowColor = UIColor.black.cgColor
         layer.shadowOffset = CGSize(width: 0, height: 1)
         layer.shadowRadius = 2
         layer.shadowOpacity = 0.3
         
         layer.masksToBounds = false //<-
        
    }
}
