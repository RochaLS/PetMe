//
//  VaccineInfoTableViewCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-02.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class VaccineInfoTableViewCell: UITableViewCell {
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Option Name"
        label.textColor = AppColors.black
        label.font = UIFont.systemFont(ofSize: 20 , weight: .regular)
        return label
    }()
    
    let switchButton: UISwitch = {
        let button = UISwitch()
        button.onTintColor = AppColors.primaryColor
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
        addSubview(switchButton)
        
        addContraintsWithFormat(format: "V:|[v0]|", views: mainLabel)
        addContraintsWithFormat(format: "H:|-20-[v0][v1]-20-|", views: mainLabel, switchButton)
        
        self.centerYAnchor.constraint(equalTo: switchButton.centerYAnchor).isActive = true
    }

}
