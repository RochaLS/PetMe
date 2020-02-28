//
//  ChooseMoodButton.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-24.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class ChooseMoodButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.black
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.3
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        NSLayoutConstraint.activate([self.heightAnchor.constraint(equalToConstant: 80)])
        
    }
    
}
