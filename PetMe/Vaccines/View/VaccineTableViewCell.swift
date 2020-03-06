//
//  VaccineTableViewCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-26.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class VaccineTableViewCell: UITableViewCell {
    
    let vaccineName: UILabel = {
        let label = UILabel()
        label.text = "Vaccine Name"
        label.textColor = AppColors.black
        label.font = UIFont.systemFont(ofSize: 20 , weight: .regular)
        return label
        
    }()
    
    let isDone: UILabel = {
        let label = UILabel()
//        label.text = "●"
        label.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        label.text = String.fontAwesomeIcon(name: .syringe
        )
        label.textColor = AppColors.red
        return label
    }()
    
    let status: UILabel = {
        let label = UILabel()
        label.text = "Status"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setupView() {
        addSubview(vaccineName)
        addSubview(isDone)
        addSubview(status)
        
        addContraintsWithFormat(format: "V:|[v0]|", views: isDone)
        addContraintsWithFormat(format: "V:|[v0]|", views: vaccineName)
        addContraintsWithFormat(format: "V:|[v0]|", views: status)
        addContraintsWithFormat(format: "H:|-20-[v0]-20-[v1]", views: isDone, vaccineName)
        addContraintsWithFormat(format: "H:[v0]-20-|", views: status)
        
        selectionStyle = .none
    }


}
