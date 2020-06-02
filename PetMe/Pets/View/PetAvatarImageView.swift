//
//  PetAvatarImageView.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-06.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class PetAvatarImageView: UIImageView {

    init() {
        super.init(image: UIImage(named: "placeholder"))
        contentMode = .scaleAspectFit
        layer.masksToBounds = true
        layer.cornerRadius = 34
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
