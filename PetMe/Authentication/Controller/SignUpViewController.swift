//
//  SignUpViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-13.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    var centerConstraint: NSLayoutConstraint?
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = AppFonts.mainFontBold
        label.font = label.font.withSize(22)
        label.textAlignment = .center
        label.textColor = AppColors.black
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = DefaultTextField()
        textField.placeholder = "Your Name..."
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = DefaultTextField()
        textField.placeholder = "Your E-mail..."
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = DefaultTextField()
        textField.placeholder = "Your Password..."
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = DoneButton()
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    var provider: UserDataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        setupViews()
        self.hideKeyboardWhenTappedAround()
        provider = UserDataProvider()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupViews() {
        view.addSubview(container)
        
        
        centerConstraint = NSLayoutConstraint(item: container, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        
        view.addConstraint(centerConstraint!)
        
        
        
        view.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: container)
        view.addContraintsWithFormat(format: "V:[v0(500)]" , views: container)
        
        container.addSubview(titleLabel)
        container.addSubview(nameTextField)
        container.addSubview(emailTextField)
        container.addSubview(passwordTextField)
        container.addSubview(signUpButton)
        
        container.addContraintsWithFormat(format: "V:|-10-[v0][v1(50)]-30-[v2(50)]-30-[v3(50)]-60-[v4(60)]-10-|", views: titleLabel, nameTextField, emailTextField, passwordTextField, signUpButton)
        container.addContraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        container.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: nameTextField)
        container.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: emailTextField)
        container.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: passwordTextField)
        container.addContraintsWithFormat(format: "H:|-20-[v0]-20-|", views: signUpButton)
    }
    
    
    @objc func buttonPressed() {
        if let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    print(error!)
                } else {
                    
                    guard name != "" else {
                        print("Missing user name")
                        return
                    }
                    
                    print("\(authResult!.user) created!")
                    self.provider.saveUserData(userID: authResult!.user.uid, userName: name)
                    
                }
                
            }
            
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
