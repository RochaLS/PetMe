//
//  EditPetViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-10-20.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class EditPetViewController: UIViewController {
    
    var pet: Pet!
    var centerConstraint: NSLayoutConstraint?
    var petImageData: Data? = nil
    var petImageName = "placeholder"
    var speciesSelected: String?
    var provider: DataManager!
    var userDataProvider: UserDataProvider!
    
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.text = "Edit Pet"
        label.font = AppFonts.mainFontBold
        label.font = label.font.withSize(22)
        label.textAlignment = .center
        return label
    }()
    
    let nameTextField: UITextField = {
        let textfield = UITextField()
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
        button.setTitleColor(AppColors.primaryColor, for: .normal)
        button.setTitle(String.fontAwesomeIcon(name: .cameraRetro), for: .normal)
        button.addTarget(self, action: #selector(addPhotoButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let uploadImageTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Change Photo"
        label.font = AppFonts.mainFontRegular
        label.font = label.font.withSize(20)
        label.textAlignment = .right
        return label
    }()
    
    let dogButton: AnimalButton = {
        let button = AnimalButton(title:  String.fontAwesomeIcon(name: .dog))
        button.addTarget(self, action: #selector(dogButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let catButton: AnimalButton = {
        let button = AnimalButton(title: String.fontAwesomeIcon(name: .cat))
        button.addTarget(self, action: #selector(catButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let doneButton: UIButton = {
        let button = DefaultButton()
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let dismissButton = DismissButton()
    
    @objc func addPhotoButtonPressed() {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.petImageData = image.jpegData(compressionQuality: 0.5)
            self.petImageName = UUID().uuidString + ".jpeg"
        }
    }
    
    @objc func doneButtonPressed() {
        provider = DataManager()
        provider.updatePetData(petID: pet.id, name: nameTextField.text, species: speciesSelected, imgName: petImageName, imgData: petImageData)
        dismiss(animated: true)
    }
    
    
    func setupViews() {
        
        //        self.view.backgroundColor = UIColor.clear
        
        view.addSubview(containerView)
        view.addSubview(dismissButton)
        
        
        containerView.addSubview(pageTitle)
        containerView.addSubview(nameTextField)
        containerView.addSubview(addPhotoButton)
        containerView.addSubview(uploadImageTextLabel)
        containerView.addSubview(doneButton)
        containerView.addSubview(dogButton)
        containerView.addSubview(catButton)
        
        view.addContraintsWithFormat(format: "V:[v0(\(410 + 20))]", views: containerView)
        view.addContraintsWithFormat(format: "V:|-5-[v0]", views: dismissButton)
        view.addContraintsWithFormat(format: "H:[v0]-5-|", views: dismissButton)
        
        
        centerConstraint = NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        view.addConstraint(centerConstraint!)
        
        view.addContraintsWithFormat(format: "H:|[v0]|", views: containerView)
        
        containerView.addContraintsWithFormat(format: "V:|-20-[v0]", views: pageTitle)
        containerView.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: pageTitle)
        containerView.addContraintsWithFormat(format: "V:|-80-[v0(50)]-20-[v1(50)]", views: nameTextField, dogButton)
        containerView.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: nameTextField)
        containerView.addContraintsWithFormat(format: "H:|-10-[v0]-20-[v1]-10-|", views: dogButton, catButton)
        
        
        NSLayoutConstraint.activate([
            catButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            catButton.widthAnchor.constraint(equalTo: dogButton.widthAnchor),
            catButton.heightAnchor.constraint(equalTo: dogButton.heightAnchor)
        ])
        
        containerView.addContraintsWithFormat(format: "H:[v0]-10-[v1]-10-|", views: uploadImageTextLabel,addPhotoButton)
        catButton.bottomAnchor.constraint(equalTo: addPhotoButton.topAnchor, constant: -20).isActive = true
        catButton.bottomAnchor.constraint(equalTo: uploadImageTextLabel.topAnchor, constant: -30).isActive = true
        
        containerView.addContraintsWithFormat(format: "H:[v1]-10-[v0]-10-|", views: addPhotoButton, uploadImageTextLabel)
        
        containerView.addContraintsWithFormat(format: "H:|-30-[v0]-30-|", views: doneButton)
        
        doneButton.topAnchor.constraint(equalTo: uploadImageTextLabel.bottomAnchor, constant: 20).isActive = true
        doneButton.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true
        
        containerView.layer.cornerRadius = 10
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        dismissButton.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupViews()
        userDataProvider = UserDataProvider()
        print("species: \(pet.species)")

        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        view.isUserInteractionEnabled = true
        self.hideKeyboardWhenTappedAround()
        
        nameTextField.text = pet.name
        
        speciesSelected = pet.species
        
        if speciesSelected == "cat" {
            catButton.isSelected = true
            catButton.backgroundColor = AppColors.primaryColor
        } else if speciesSelected == "dog" {
            dogButton.isSelected = true
            dogButton.backgroundColor = AppColors.primaryColor
        }
        
    }
    
    
    @objc func handleKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            let keyboardHeight = keyboardFrame?.cgRectValue.height
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            centerConstraint?.constant = isKeyboardShowing ? -130 : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
                
            })
        }
    }
    
    @objc func catButtonPressed() {
        if dogButton.isSelected == true {
            dogButton.isSelected = false
            dogButton.backgroundColor = UIColor.white
        }
        catButton.isSelected = true
        catButton.backgroundColor = AppColors.primaryColor
        speciesSelected = "cat"
    }
    
    @objc func dogButtonPressed() {
        
        if catButton.isSelected == true {
            catButton.isSelected = false
            catButton.backgroundColor = UIColor.white
        }
        
        dogButton.isSelected = true
        dogButton.backgroundColor = AppColors.primaryColor
        
        speciesSelected = "dog"
    }
    
    @objc func dismissPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
