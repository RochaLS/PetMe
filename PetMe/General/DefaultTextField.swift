//
//  DefaultTextField.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-13.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class DefaultTextField: UITextField {

    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.white
        textAlignment = .center
        borderStyle = .roundedRect
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
