//
//  DoneButton.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-13.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class DefaultButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = AppColors.primaryColor
        layer.cornerRadius = 5
        titleLabel?.font = AppFonts.mainFontMedium
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
