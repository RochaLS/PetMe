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
        layer.cornerRadius = 5
        layer.borderWidth = 0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
        
        layer.masksToBounds = false //<-
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Drika"
        label.textColor = UIColor(rgb: 0x21bf73)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        return label
        
    }()
    
    let dogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 34
        
        return imageView
    }()
    
    func setupViews() {
        
        addSubview(nameLabel)
        addSubview(dogImageView)
        
        
        dogImageView.image = UIImage(named: "drika")
        
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //        addContraintsWithFormat(format: "H:|-12-[v0(68)]", views: dogImageView)
        addContraintsWithFormat(format: "V:[v0(68)]", views: dogImageView)
        
        //Center ImageView:
        
        addConstraint(NSLayoutConstraint(item: dogImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addContraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addContraintsWithFormat(format: "H:|-12-[v0(68)]-20-[v1]|", views: dogImageView, nameLabel)
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
