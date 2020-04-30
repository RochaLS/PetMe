//
//  DismissButton.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-30.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class DismissButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setImage(UIImage.fontAwesomeIcon(name: .times, style: .solid, textColor: AppColors.black, size: CGSize(width: 30, height: 30)), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
