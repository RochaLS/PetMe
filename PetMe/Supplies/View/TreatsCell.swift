//
//  TreatsCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-26.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class TreatsCell: GeneralCell {
    
    let nameLabel: UILabel = {
        let label = FixedLabel()
        label.text = "Name:"
        return label
    }()
    
    let brandLabel: UILabel = {
        let label = FixedLabel()
        label.text = "Brand:"
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
    let brandAnswer = AnswerLabel()
    
    let trashButton = TrashButton()
    
    var treat: Treat!
    
    weak var delegate: TreatCellDelegate?
    
    
    
    override func setupViews() {
        addSubview(nameLabel)
        addSubview(brandLabel)
        addSubview(nameAnswer)
        addSubview(brandAnswer)
        addSubview(petImageView)
        addSubview(trashButton)
        
        addContraintsWithFormat(format: "V:|-10-[v0(20)]-5-[v1(20)]", views: nameLabel, brandLabel)
        addContraintsWithFormat(format: "V:|-10-[v0(20)]-5-[v1(20)]-10-[v2]-10-|", views: nameAnswer, brandAnswer, petImageView)
        addContraintsWithFormat(format: "H:|-10-[v0]-5-[v1]", views: nameLabel, nameAnswer)
        addContraintsWithFormat(format: "H:|-10-[v0]-5-[v1]", views: brandLabel, brandAnswer)
        addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: petImageView)
        addContraintsWithFormat(format: "V:|-10-[v0]", views: trashButton)
        addContraintsWithFormat(format: "H:[v0]-10-|", views: trashButton)
        
        trashButton.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
       
        
    }
    
    func setupTreat(treat: Treat) {
        self.treat = treat
    }
    
    @objc func deletePressed() {
        self.delegate?.didTapRemove(itemToRemove: treat)
    }
    
}
