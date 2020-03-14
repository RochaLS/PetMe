//
//  AddReminderViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-09.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class AddReminderViewController: UIViewController {
    
    var bottomConstraint: NSLayoutConstraint?
    var provider: ReminderDataProvider! = nil
    
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
        let button = DoneButton()
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.clear
        setupViews()
        provider = ReminderDataProvider()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupViews() {
        view.addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(reminderTextField)
        container.addSubview(doneButton)
        
        // Container Constraints
        view.addContraintsWithFormat(format: "V:[v0(\(310 + 20))]", views: container)
        view.addContraintsWithFormat(format: "H:|[v0]|", views: container)
        
        bottomConstraint = NSLayoutConstraint(item: container, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraint(bottomConstraint!)
        
        container.layer.cornerRadius = 10
        container.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        //
        
        container.addContraintsWithFormat(format: "V:|-40-[v0]-40-[v1(50)]-40-[v2(50)]", views: titleLabel, reminderTextField, doneButton)
        container.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: titleLabel)
        
        container.addContraintsWithFormat(format: "H:|-20-[v0]-20-|", views: reminderTextField)
        container.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: doneButton)
    }
    
    @objc func doneButtonPressed() {
        //TODO Create reminder here:
        if reminderTextField.text?.isEmpty == false && reminderTextField.text != "" {
            let newReminder = Reminder(title: reminderTextField.text!, id: UUID().uuidString, createdBy: "Lucas", createdAt: Date())
            provider.addReminderDataToFirestore(reminder: newReminder)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // Need to refactor this later
    @objc func handleKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            let keyboardHeight = keyboardFrame?.cgRectValue.height
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight! : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
                
            })
        }
    }
}
