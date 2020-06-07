//
//  FavoriteFoodsViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-27.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class CreateFavoriteFoodViewController: AddBasicPageViewController {
    
    var pet: Pet!
    var centerConstraint: NSLayoutConstraint?
    var foodImageData: Data? = nil
    var foodImageName = ""
    var provider: SuppliesDataProvider!
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupViews()
        provider = SuppliesDataProvider()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func setupViews() {
        view.addSubview(pageTitle)
        view.addSubview(containerView)
        view.addSubview(addButton)
        view.addSubview(dismissButton)
        addButton.setTitle("Add", for: .normal)
        pageTitle.text = "Add Favorite Food"
        
        view.addContraintsWithFormat(format: "V:|-5-[v0]", views: dismissButton)
        view.addContraintsWithFormat(format: "H:[v0]-5-|", views: dismissButton)
        view.addContraintsWithFormat(format: "H:|[v0]|", views: pageTitle)
        view.addContraintsWithFormat(format: "H:|-20-[v0]-20-|", views: containerView)
        view.addContraintsWithFormat(format: "V:[v0]-40-[v1(320)]-40-[v2(50)]", views: pageTitle, containerView, addButton)
        view.addContraintsWithFormat(format: "H:|-30-[v0]-30-|", views: addButton)
        
        centerConstraint = NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        view.addConstraint(centerConstraint!)
        
        containerView.addSubview(brandTextField)
        containerView.addSubview(breedSizeTextField)
        containerView.addSubview(flavourTextField)
        containerView.addSubview(typeTextField)
        containerView.addSubview(photoButton)
        
        containerView.addContraintsWithFormat(format: "V:|[v0(50)]-20-[v1(50)]-20-[v2(50)]-20-[v3(50)]-20-[v4]", views: brandTextField, breedSizeTextField, flavourTextField, typeTextField, photoButton)
        containerView.addContraintsWithFormat(format: "H:|[v0]|", views: brandTextField)
        containerView.addContraintsWithFormat(format: "H:|[v0]|", views: breedSizeTextField)
        containerView.addContraintsWithFormat(format: "H:|[v0]|", views: flavourTextField)
        containerView.addContraintsWithFormat(format: "H:|[v0]|", views: typeTextField)
        containerView.addContraintsWithFormat(format: "H:[v0]|", views: photoButton)
        
        dismissButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        photoButton.addTarget(self, action: #selector(addPhotoButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func didTapDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapAdd() {
        //Save Stuff...
        if NetworkManager.monitor.currentPath.status == .satisfied {
            if foodImageData == nil {
                foodImageName = "supply-placeholder"
                foodImageData = UIImage(named: "loading-placeholder")?.jpegData(compressionQuality: 0.75)
            }
            
            if let brand = brandTextField.text, let breedSize = breedSizeTextField.text, let flavour = flavourTextField.text, let type = typeTextField.text {
                if brand == "" || breedSize == "" || flavour == "" || type == "" {
                    Banners.emptyInfo.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: self)
                } else {
                    
                    let newFood = Food(brand: brand, breedSize: breedSize, flavour: flavour, type: type, imgName: foodImageName, id: UUID().uuidString, petID: pet.id)
                    provider.saveFoodData(petID: pet.id, imgData: foodImageData ?? nil, imgName: foodImageName , food: newFood)
                    self.dismiss(animated: true) {
                        self.brandTextField.text = ""
                        self.breedSizeTextField.text = ""
                        self.flavourTextField.text = ""
                        self.typeTextField.text = ""
                    }
                }
            }
        } else {
            Banners.showBottomBanner(on: self)
        }
        
        
    }
    
    @objc func addPhotoButtonPressed() {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.foodImageData = image.jpegData(compressionQuality: 0.75)
            self.foodImageName = UUID().uuidString + ".jpeg"
        }
    }
    
    @objc func handleKeyboard(notification: Notification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            _ = keyboardFrame?.cgRectValue.height
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            centerConstraint?.constant = isKeyboardShowing ? -130 : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
                
            })
        }
    }
    
    
    
}
