//
//  FavoriteFoodsViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-27.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class CreateFavoriteFoodViewController: UIViewController {
    
    var pet: Pet!
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let pageTitle: UILabel = {
           let label = UILabel()
           label.text = "Add a Favorite Food"
           label.font = AppFonts.mainFontBold
           label.font = label.font.withSize(22)
           label.textAlignment = .center
           return label
       }()
    
    let brandTextField: UITextField = {
        let textField = DefaultTextField()
        textField.placeholder = "Food Brand"
        return textField
    }()
    
    let breedSizeTextField: UITextField = {
        let textField = DefaultTextField()
        textField.placeholder = "Breed Size"
        return textField
    }()
    
    let flavourTextField: UITextField = {
        let textField = DefaultTextField()
        textField.placeholder = "Food Flavour"
        return textField
    }()
    
    let typeTextField: UITextField = {
        let textField = DefaultTextField()
        textField.placeholder = "Type ex: Dry Food"
        return textField
    }()
    
    let addButton = DefaultButton()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.fontAwesomeIcon(name: .times, style: .solid, textColor: AppColors.black, size: CGSize(width: 30, height: 30)), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupViews()
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
        view.addContraintsWithFormat(format: "V:[v0]-40-[v1(260)]-40-[v2(50)]", views: pageTitle, containerView, addButton)
        view.addContraintsWithFormat(format: "H:|-30-[v0]-30-|", views: addButton)
        view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addSubview(brandTextField)
        containerView.addSubview(breedSizeTextField)
        containerView.addSubview(flavourTextField)
        containerView.addSubview(typeTextField)
        
        containerView.addContraintsWithFormat(format: "V:|[v0(50)]-20-[v1(50)]-20-[v2(50)]-20-[v3(50)]", views: brandTextField, breedSizeTextField, flavourTextField, typeTextField)
        containerView.addContraintsWithFormat(format: "H:|[v0]|", views: brandTextField)
        containerView.addContraintsWithFormat(format: "H:|[v0]|", views: breedSizeTextField)
        containerView.addContraintsWithFormat(format: "H:|[v0]|", views: flavourTextField)
        containerView.addContraintsWithFormat(format: "H:|[v0]|", views: typeTextField)
        
        dismissButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        
    }
    
    @objc func didTapDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapAdd() {
        //Save Stuff...
    }
    

}
