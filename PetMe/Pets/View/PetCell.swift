//
//  PetCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-01-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class PetCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.cornerRadius = 20
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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Drika"
        label.textColor = AppColors.primaryColor
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        return label
        
    }()
    
    let petImageView = PetAvatarImageView()
    
    func setupViews() {
        
        addSubview(nameLabel)
        addSubview(petImageView)
        

        
        petImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //        addContraintsWithFormat(format: "H:|-12-[v0(68)]", views: dogImageView)
        addContraintsWithFormat(format: "V:[v0(68)]", views: petImageView)
        
        //Center ImageView:
        
        addConstraint(NSLayoutConstraint(item: petImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addContraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addContraintsWithFormat(format: "H:|-12-[v0(68)]-20-[v1]|", views: petImageView, nameLabel)
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
