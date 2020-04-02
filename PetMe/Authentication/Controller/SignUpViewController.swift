//
//  SignUpViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-13.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseInstanceID

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
        let button = DefaultButton()
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    let goToLoginButton: UIButton = {
        let button = DefaultButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(AppColors.primaryColor, for: .normal)
        button.addTarget(self, action: #selector(goToLoginPressed), for: .touchUpInside)
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
        container.addSubview(goToLoginButton)
        
        container.addContraintsWithFormat(format: "V:|-10-[v0][v1(50)]-30-[v2(50)]-30-[v3(50)]-60-[v4(60)]-10-[v5(50)]|", views: titleLabel, nameTextField, emailTextField, passwordTextField, signUpButton, goToLoginButton)
        container.addContraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        container.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: nameTextField)
        container.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: emailTextField)
        container.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: passwordTextField)
        container.addContraintsWithFormat(format: "H:|-20-[v0]-20-|", views: signUpButton)
        container.addContraintsWithFormat(format: "H:|-30-[v0]-30-|", views: goToLoginButton)
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
                    
                    let newUser = User(name: name, userID: authResult!.user.uid , groupID: UUID().uuidString, email: email)
                    
                    self.provider.saveUserData(user: newUser)
                    //                    self.provider.setGroupData(user: newUser)
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.provider.goToPets(from: self)
                    
                    let instance = InstanceID.instanceID()
                    instance.deleteID { (error) in
                        print(error.debugDescription)
                    }
                    
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
    
    @objc func goToLoginPressed() {
        let controller = LoginViewController()
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
}
