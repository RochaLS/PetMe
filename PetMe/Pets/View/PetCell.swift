//
//  PetCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-01-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import SwipeCellKit
class PetCell: SwipeCollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 0
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 0.3
        
        contentView.layer.masksToBounds = false //<-
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Drika"
        label.textColor = AppColors.black
        label.font = AppFonts.mainFontRegular
        label.font = label.font.withSize(22)
        
        return label
        
    }()
    
    let petImageView = PetAvatarImageView()
    
    func setupViews() {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(petImageView)
        

        
        petImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //        addContraintsWithFormat(format: "H:|-12-[v0(68)]", views: dogImageView)
        contentView.addContraintsWithFormat(format: "V:[v0(68)]", views: petImageView)
        
        //Center ImageView:
        
        contentView.addConstraint(NSLayoutConstraint(item: petImageView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
        contentView.addContraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        contentView.addContraintsWithFormat(format: "H:|-12-[v0(68)]-20-[v1]|", views: petImageView, nameLabel)
    }
}

extension UIView {
    func addContraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String:UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // Better to write code below just once ;)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: .init(), metrics: nil, views: viewsDictionary))
    }
}
