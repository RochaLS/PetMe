//
//  ReminderCollectionViewCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-09.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class ReminderCollectionViewCell: UICollectionViewCell {
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
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    let createdByLabel: UILabel = {
        let label = UILabel()
        label.text = "Gabriel"
        label.numberOfLines = 0
        label.textColor = AppColors.primaryColor
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    let createdAtLabel: UILabel = {
        let label = UILabel()
        label.text = "20/10/20"
        label.numberOfLines = 0
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(createdByLabel)
        addSubview(createdAtLabel)
        addContraintsWithFormat(format: "V:|[v0]|", views: titleLabel)
        addContraintsWithFormat(format: "H:|-15-[v0]-15-|", views: titleLabel)
        addContraintsWithFormat(format: "V:|-10-[v0]", views: createdAtLabel)
        addContraintsWithFormat(format: "H:[v0]-15-|", views: createdAtLabel)
        addContraintsWithFormat(format: "V:|-10-[v0]", views: createdByLabel)
        addContraintsWithFormat(format: "H:|-15-[v0]", views: createdByLabel)
    }
}
