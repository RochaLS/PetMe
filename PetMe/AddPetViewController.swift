//
//  AddPetViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-01-30.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FontAwesome_swift

class AddPetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.text = "Add Pet"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let nameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Pet Name"
        textfield.backgroundColor = UIColor.white
        textfield.textAlignment = .center
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    
    let birthDateTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Pet Birth Date"
        textfield.textAlignment = .center
        textfield.backgroundColor = UIColor.white
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    
    let addPhotoButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        button.setTitleColor(UIColor(rgb: 0x21bf73), for: .normal)
        button.setTitle(String.fontAwesomeIcon(name: .cameraRetro), for: .normal)
        return button
    }()
    
    let uploadImageTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Upload Photo"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor(rgb: 0x333333)
        label.textAlignment = .right
        return label
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Done", for: .normal)
        button.backgroundColor = UIColor(rgb: 0x21bf73)
        button.layer.cornerRadius = 5
        return button
    }()
    
    
    
    
    func setupViews() {
        
        self.view.backgroundColor = UIColor.clear
        
        
        view.addSubview(containerView)
        
        
        containerView.addSubview(pageTitle)
        containerView.addSubview(nameTextField)
        containerView.addSubview(birthDateTextField)
        containerView.addSubview(addPhotoButton)
        containerView.addSubview(uploadImageTextLabel)
        containerView.addSubview(doneButton)
        
        view.addContraintsWithFormat(format: "V:[v0(\(350 + 20))]|", views: containerView)
        view.addContraintsWithFormat(format: "H:|[v0]|", views: containerView)
        
        containerView.addContraintsWithFormat(format: "V:|-20-[v0]", views: pageTitle)
        containerView.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: pageTitle)
        containerView.addContraintsWithFormat(format: "V:|-80-[v0(50)]-20-[v1(50)]-20-[v2]-20-[v3(50)]", views: nameTextField, birthDateTextField, addPhotoButton, doneButton)
        containerView.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: nameTextField)
        containerView.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: birthDateTextField)
        
        containerView.addContraintsWithFormat(format: "H:[v1]-10-[v0]-10-|", views: addPhotoButton, uploadImageTextLabel)
        
        containerView.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: doneButton)
        
        //        view.addContraintsWithFormat(format: "V:|-230-[v0]", views: uploadImageTextLabel)
        
        view.addConstraint(NSLayoutConstraint(item: uploadImageTextLabel, attribute: .top, relatedBy: .equal, toItem: addPhotoButton, attribute: .top, multiplier: 1, constant: 10))
        
        containerView.layer.cornerRadius = 10
        
        
    }
    
    
}
