//
//  ToyCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-26.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class ToyCell: GeneralCell {
    
    let nameLabel: UILabel = {
        let label = FixedLabel()
        label.text = "Name:"
        return label
    }()
    
    let petImageView: UIImageView = {
        let imgview = UIImageView()
        imgview.backgroundColor = UIColor.white
        imgview.image = UIImage(named: "loading-placeholder")
        imgview.contentMode = .scaleAspectFit
        return imgview
    }()
    
     let nameAnswer = AnswerLabel()
    
    override func setupViews() {
        addSubview(nameLabel)
        addSubview(nameAnswer)
        addSubview(petImageView)
        
        addContraintsWithFormat(format: "V:|-10-[v0]-10-[v1]-10-|", views: nameLabel, petImageView)
        addContraintsWithFormat(format: "V:|-10-[v0]", views: nameAnswer)
        addContraintsWithFormat(format: "H:|-10-[v0]-5-[v1]", views: nameLabel, nameAnswer)
        addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: petImageView)
    }
    
//    override func setData() {
//        provider.getToyData(petID: GlobalVariables.petID)
//    }
}
