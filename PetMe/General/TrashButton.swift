//
//  TrashButton.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class TrashButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setImage(UIImage.fontAwesomeIcon(name: .trash, style: .solid, textColor: AppColors.red, size: CGSize(width: 25, height: 25)), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
