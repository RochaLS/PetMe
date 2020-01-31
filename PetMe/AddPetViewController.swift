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
        
        self.view.backgroundColor = UIColor.white
        
        setupViews()

        // Do any additional setup after loading the view.
    }
    
    
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
        textfield.backgroundColor = UIColor(rgb: 0xF6F6F6)
        textfield.textAlignment = .center
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    
    let birthDateTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Pet Birth Date"
        textfield.textAlignment = .center
        textfield.backgroundColor = UIColor(rgb: 0xF6F6F6)
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
        view.addSubview(pageTitle)
        view.addSubview(nameTextField)
        view.addSubview(birthDateTextField)
        view.addSubview(addPhotoButton)
        view.addSubview(uploadImageTextLabel)
        view.addSubview(doneButton)
        
        view.addContraintsWithFormat(format: "V:|-20-[v0]", views: pageTitle)
        view.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: pageTitle)
        view.addContraintsWithFormat(format: "V:|-80-[v0(50)]-20-[v1(50)]-20-[v2]-20-[v3(50)]", views: nameTextField, birthDateTextField, addPhotoButton, doneButton)
        view.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: nameTextField)
        view.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: birthDateTextField)
        
        view.addContraintsWithFormat(format: "H:[v1]-10-[v0]-10-|", views: addPhotoButton, uploadImageTextLabel)
        
        view.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: doneButton)
        
//        view.addContraintsWithFormat(format: "V:|-230-[v0]", views: uploadImageTextLabel)
        
        view.addConstraint(NSLayoutConstraint(item: uploadImageTextLabel, attribute: .top, relatedBy: .equal, toItem: addPhotoButton, attribute: .top, multiplier: 1, constant: 10))
        
        
    }
    

}
