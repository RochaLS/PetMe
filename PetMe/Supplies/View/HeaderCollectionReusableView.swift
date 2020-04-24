//
//  HeaderCollectionReusableView.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-24.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.mainFontMedium?.withSize(20)
        label.textAlignment = .center
        label.textColor = AppColors.black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(titleLabel)
        addContraintsWithFormat(format: "V:|[v0]|", views: titleLabel)
        addContraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
    }
}
