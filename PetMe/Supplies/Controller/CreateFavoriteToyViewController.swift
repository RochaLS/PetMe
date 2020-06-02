//
//  CreateFavoriteToyViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-27.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class CreateFavoriteToyViewController: AddBasicPageViewController {
    
    var pet: Pet!
    var centerConstraint: NSLayoutConstraint?
    var toyImageData: Data? = nil
    var toyImageName = "placeholder"
    var provider: SuppliesDataProvider!
    
    let nameTextField: UITextField = {
        let textField = DefaultTextField()
        textField.placeholder = "Toy Name"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
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
        pageTitle.text = "Add Favorite Toy"
        
        view.addContraintsWithFormat(format: "V:|-5-[v0]", views: dismissButton)
        view.addContraintsWithFormat(format: "H:[v0]-5-|", views: dismissButton)
        view.addContraintsWithFormat(format: "H:|[v0]|", views: pageTitle)
        view.addContraintsWithFormat(format: "H:|-20-[v0]-20-|", views: containerView)
        view.addContraintsWithFormat(format: "V:[v0]-40-[v1(90)]-40-[v2(50)]", views: pageTitle, containerView, addButton)
        view.addContraintsWithFormat(format: "H:|-30-[v0]-30-|", views: addButton)
        
        centerConstraint = NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        view.addConstraint(centerConstraint!)
        
        
        
        containerView.addSubview(nameTextField)
        containerView.addSubview(photoButton)
        
        containerView.addContraintsWithFormat(format: "V:|[v0(50)]-20-[v1]", views: nameTextField, photoButton)
        containerView.addContraintsWithFormat(format: "H:|[v0]|", views: nameTextField)
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
            if toyImageData == nil {
                toyImageName = "-"
                toyImageData = UIImage(named: "loading-placeholder")?.jpegData(compressionQuality: 0.75)
                
            }
            
            if let name = nameTextField.text {
                if name == "" {
                    Banners.emptyInfo.show(queuePosition: .front, bannerPosition: .bottom, queue:.default, on: self)
                } else {
                    
                    let newToy = Toy(name: name, imgName: toyImageName, petID: pet.id, id: UUID().uuidString)
                    if toyImageData != nil {
                        provider.saveToyData(petID: pet.id, imgData: toyImageData!, imgName: toyImageName, toy: newToy)
                    } else {
                         provider.saveToyData(petID: pet.id, imgData: nil, imgName: toyImageName, toy: newToy)
                    }
                    
                    
                    self.dismiss(animated: true) {
                        self.nameTextField.text = ""
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
            self.toyImageData = image.jpegData(compressionQuality: 0.75)
            self.toyImageName = UUID().uuidString + ".jpeg"
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
