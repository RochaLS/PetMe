//
//  AboutTableViewCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-06.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class AboutTableViewCell: UITableViewCell {
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Option Name"
        label.textColor = AppColors.black
        label.font = AppFonts.mainFontRegular
        label.font = label.font.withSize(20)
        label.textAlignment = .justified
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupView() {
        addSubview(mainLabel)
        
        addContraintsWithFormat(format: "V:|-20-[v0]-20-|", views: mainLabel)
        addContraintsWithFormat(format: "H:|-20-[v0]-20-|", views: mainLabel)
        
    }
    
}
