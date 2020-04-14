//
//  GroupTableViewCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-30.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    weak var delegate: GroupCellDelegate?
    var member: User!
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Option Name"
        label.textColor = AppColors.black
        label.font = AppFonts.mainFontRegular
        label.font = label.font.withSize(20)
        return label
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Remove"
        button.setImage(UIImage.fontAwesomeIcon(name: .times, style: .solid, textColor: AppColors.red, size: CGSize(width: 38, height: 38)), for: .normal)
        return button
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
        addSubview(nameLabel)
        addSubview(deleteButton)
        
        deleteButton.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        
        addContraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addContraintsWithFormat(format: "H:|-20-[v0][v1]-20-|", views: nameLabel, deleteButton)
        addContraintsWithFormat(format: "V:|[v0]|", views: deleteButton)
    }
    
    func setupMember(member: User) {
         self.member = member
     }
    
    @objc func deletePressed() {
        self.delegate?.didTapRemove(member: member)
    }

}
