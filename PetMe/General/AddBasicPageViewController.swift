//
//  AddBasicPageViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-27.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class AddBasicPageViewController: UIViewController {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let addButton = DefaultButton()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.fontAwesomeIcon(name: .times, style: .solid, textColor: AppColors.black, size: CGSize(width: 30, height: 30)), for: .normal)
        return button
    }()
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = AppFonts.mainFontBold
        label.font = label.font.withSize(22)
        label.textAlignment = .center
        return label
    }()
    
    let photoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.fontAwesomeIcon(name: .cameraRetro, style: .solid, textColor: AppColors.primaryColor, size: CGSize(width: 40, height: 40)), for: .normal)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }
    
    func setupViews() {
        view.addSubview(pageTitle)
        view.addSubview(containerView)
        view.addSubview(addButton)
        view.addSubview(dismissButton)
        addButton.setTitle("Add", for: .normal)
        
        view.addContraintsWithFormat(format: "V:|-5-[v0]", views: dismissButton)
        view.addContraintsWithFormat(format: "H:[v0]-5-|", views: dismissButton)
        view.addContraintsWithFormat(format: "H:|[v0]|", views: pageTitle)
        view.addContraintsWithFormat(format: "H:|-20-[v0]-20-|", views: containerView)
        view.addContraintsWithFormat(format: "V:[v0]-40-[v1(120)]-40-[v2(50)]", views: pageTitle, containerView, addButton)
        view.addContraintsWithFormat(format: "H:|-30-[v0]-30-|", views: addButton)
        view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
}
