//
//  AddReminderViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-09.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftSpinner
import NotificationBannerSwift

class AddReminderViewController: UIViewController {
    
    var centerConstraint: NSLayoutConstraint?
    var provider: ReminderDataProvider! = nil
    var userDataProvider: UserDataProvider!
    
    let container : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.mainFontBold
        label.font = label.font.withSize(24)
        label.text = "Add a Reminder"
        label.textColor = AppColors.black
        label.textAlignment = .center
        return label
    }()
    
    let reminderTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.placeholder = "Your Reminder..."
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let doneButton: UIButton = {
        let button = DefaultButton()
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let dismissButton = DismissButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        setupViews()
        provider = ReminderDataProvider()
        userDataProvider = UserDataProvider()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
         self.hideKeyboardWhenTappedAround()
        
    }
    
    func setupViews() {
        view.addSubview(container)
        view.addSubview(dismissButton)
        container.addSubview(titleLabel)
        container.addSubview(reminderTextField)
        container.addSubview(doneButton)
        
        // Container Constraints
        view.addContraintsWithFormat(format: "V:|-5-[v0]", views: dismissButton)
        view.addContraintsWithFormat(format: "H:[v0]-5-|", views: dismissButton)
        view.addContraintsWithFormat(format: "V:[v0(\(310 + 20))]", views: container)
        view.addContraintsWithFormat(format: "H:|[v0]|", views: container)
        
        centerConstraint = NSLayoutConstraint(item: container, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        
        view.addConstraint(centerConstraint!)
        
        container.layer.cornerRadius = 10
        container.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        //
        
        container.addContraintsWithFormat(format: "V:|-40-[v0]-40-[v1(50)]-40-[v2(50)]", views: titleLabel, reminderTextField, doneButton)
        container.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: titleLabel)
        
        container.addContraintsWithFormat(format: "H:|-20-[v0]-20-|", views: reminderTextField)
        container.addContraintsWithFormat(format: "H:|-30-[v0]-30-|", views: doneButton)
        
        dismissButton.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
    }
    
    @objc func doneButtonPressed() {
        //TODO Create reminder here:
        if NetworkManager.monitor.currentPath.status == .satisfied {
            if reminderTextField.text?.isEmpty == false && reminderTextField.text != "" {
                userDataProvider.getUser(id: Auth.auth().currentUser!.uid) { (user) in
                    let newReminder = Reminder(title: self.reminderTextField.text!, id: UUID().uuidString, createdBy: user.name, createdAt: Date(), groupID: user.groupID, userID: Auth.auth().currentUser!.uid)
                    self.provider.addReminderDataToFirestore(reminder: newReminder)
                }
                self.dismiss(animated: true)
            } else {
                Banners.emptyInfo.show(queuePosition: .front, bannerPosition: .bottom, queue:.default, on: self)
            }
        } else {
            Banners.showBottomBanner(on: self)        }
        
    }
    
    // Need to refactor this later
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
    
    @objc func dismissPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
