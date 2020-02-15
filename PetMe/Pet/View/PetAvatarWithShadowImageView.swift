//
//  PetAvatarWithShadowImageView.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-06.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class PetAvatarWithBorderImageView: UIImageView {
    init() {
        super.init(image: UIImage(named: "Preto"))
        contentMode = .scaleToFill
        layer.masksToBounds = true
        layer.cornerRadius = 75
        layer.borderWidth = 5
        layer.borderColor = UIColor.white.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
