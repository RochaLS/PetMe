//
//  InvitesTableViewCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-05.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class InvitesTableViewCell: UITableViewCell {
    
    let mainLabel: UILabel = {
          let label = UILabel()
          label.text = "Join name's group?"
          label.textColor = AppColors.black
          label.font = AppFonts.mainFontRegular
          label.font = label.font.withSize(18)
          return label
      }()
    
    let acceptButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColors.primaryColor
        button.setTitle("Accept", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
//        button.setImage(UIImage.fontAwesomeIcon(name: .check, style: .solid, textColor: AppColors.primaryColor, size: CGSize(width: 35, height: 35)), for: .normal)
        return button
    }()
    
    let declineButton: UIButton = {
        let button = UIButton()
        button.setTitle("Decline", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = AppColors.red
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        button.titleLabel?.font = AppFonts.mainFontRegular
//        button.setImage(UIImage.fontAwesomeIcon(name: .times, style: .solid, textColor: AppColors.red, size: CGSize(width: 35, height: 35)), for: .normal)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        addSubview(mainLabel)
        addSubview(acceptButton)
        addSubview(declineButton)
        
        addContraintsWithFormat(format: "V:|[v0]|", views: mainLabel)
        addContraintsWithFormat(format: "V:[v0(40)]", views: acceptButton)
        addContraintsWithFormat(format: "V:[v0(40)]", views: declineButton)
        
        addContraintsWithFormat(format: "H:|-10-[v0]-5-[v1(80)]-5-[v2(80)]-5-|", views: mainLabel, acceptButton, declineButton)
        
        addConstraint(NSLayoutConstraint(item: acceptButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: declineButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }

}
