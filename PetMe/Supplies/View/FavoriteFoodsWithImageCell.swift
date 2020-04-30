//
//  FavoriteFoodsWithImageCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-24.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class FavoriteFoodsWithImageCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.cornerRadius = 8
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
    
    weak var delegate: FoodCellDelegate?
    
    let petImageView: UIImageView = {
        let imgview = UIImageView()
        imgview.backgroundColor = UIColor.white
        imgview.image = UIImage(named: "loading-placeholder")
        imgview.contentMode = .scaleAspectFit
        return imgview
    }()
    
    let brandLabel: UILabel = {
        let label = FixedLabel()
        label.text = "Brand:"
        return label
    }()
    
    let flavourLabel: UILabel = {
        let label = FixedLabel()
        label.text = "Flavour:"
        return label
    }()
    
    let breedSizeLabel: UILabel = {
        let label = FixedLabel()
        label.text = "Breed Size:"
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = FixedLabel()
        label.text = "Type:"
        return label
    }()
    
    let trashButton = TrashButton()
    
    
    let brandAnswer = AnswerLabel()
    let flavourAnswer = AnswerLabel()
    let breedSizeAnswer = AnswerLabel()
    let typeAnswer = AnswerLabel()
    
    var food: Food!
    
    
    func setupViews() {
        
        addSubview(brandLabel)
        addSubview(flavourLabel)
        addSubview(breedSizeLabel)
        addSubview(typeLabel)
        addSubview(brandAnswer)
        addSubview(flavourAnswer)
        addSubview(breedSizeAnswer)
        addSubview(typeAnswer)
        addSubview(petImageView)
        addSubview(trashButton)
        
        
        addContraintsWithFormat(format: "V:|-10-[v0(20)]-5-[v1(20)]-5-[v2(20)]-5-[v3(20)]", views: brandLabel, flavourLabel, breedSizeLabel, typeLabel)
        addContraintsWithFormat(format: "V:|-10-[v0(20)]-5-[v1(20)]-5-[v2(20)]-5-[v3(20)]-10-[v4]-10-|" , views: brandAnswer, flavourAnswer, breedSizeAnswer, typeAnswer, petImageView)
        addContraintsWithFormat(format: "H:|-10-[v0]-5-[v1]", views: brandLabel, brandAnswer)
        addContraintsWithFormat(format: "H:|-10-[v0]-5-[v1]", views: flavourLabel, flavourAnswer)
        addContraintsWithFormat(format: "H:|-10-[v0]-5-[v1]", views: breedSizeLabel, breedSizeAnswer)
        addContraintsWithFormat(format: "H:|-10-[v0]-5-[v1]", views: typeLabel, typeAnswer)
        addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: petImageView)
        addContraintsWithFormat(format: "V:|-10-[v0]", views: trashButton)
        addContraintsWithFormat(format: "H:[v0]-10-|", views: trashButton)
        
        trashButton.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        
    }
    
    func setupFood(food: Food) {
        self.food = food
    }
    
    @objc func deletePressed() {
        self.delegate?.didTapRemove(itemToRemove: food)
    }
    
    
}
