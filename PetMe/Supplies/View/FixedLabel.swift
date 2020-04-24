//
//  FixedLabel.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-24.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class FixedLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        font = AppFonts.mainFontMedium?.withSize(18)
        textColor = AppColors.primaryColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
