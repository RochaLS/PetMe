//
//  AnimalButton.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-28.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FontAwesome_swift

class AnimalButton: UIButton {
    
    var title: String
    
    init(title: String) {
        self.title = title // Needs to come first
        super.init(frame: .zero)
        titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        setTitle(title, for: .normal)
        backgroundColor = UIColor.white
        setTitleColor(AppColors.primaryColor, for: .normal)
        setTitleColor(UIColor.white, for: .selected)
        layer.borderWidth = 3
        layer.borderColor = AppColors.primaryColor.cgColor
        layer.cornerRadius = 8
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
