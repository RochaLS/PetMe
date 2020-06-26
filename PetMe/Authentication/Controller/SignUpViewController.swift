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
import NotificationBannerSwift

class SignUpViewController: UIViewController {
    
    var centerConstraint: NSLayoutConstraint?
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let infoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let legalInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "By tapping Sign Up you agree to our:"
        label.font = AppFonts.mainFontMedium
        label.font = label.font.withSize(18)
        label.textAlignment = .center
        label.textColor = UIColor.gray
        return label
    }()
    
    let termsAndConditions: UIButton = {
        let button = UIButton()
        button.setTitle("Terms and Conditions", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(AppColors.primaryColor, for: .normal)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    let privacyPolicy: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(AppColors.primaryColor, for: .normal)
        button.backgroundColor = UIColor.clear
        return button
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
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = DefaultTextField()
        textField.placeholder = "Your Password (6 characters long or more)"
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
    var groupProvider: GroupDataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        setupViews()
        self.hideKeyboardWhenTappedAround()
        provider = UserDataProvider()
        groupProvider = GroupDataProvider()
        
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
        container.addSubview(legalInfoLabel)
        container.addSubview(termsAndConditions)
        container.addSubview(privacyPolicy)
        
        container.addContraintsWithFormat(format: "V:|[v0]-20-[v1(50)]-20-[v2(50)]-20-[v3(50)]-30-[v4(60)]-10-[v5(50)]-10-[v6]-10-[v7]-10-[v8]|", views: titleLabel, nameTextField, emailTextField, passwordTextField, signUpButton, goToLoginButton, legalInfoLabel, termsAndConditions, privacyPolicy)
        container.addContraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        container.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: nameTextField)
        container.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: emailTextField)
        container.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: passwordTextField)
        container.addContraintsWithFormat(format: "H:|-20-[v0]-20-|", views: signUpButton)
        container.addContraintsWithFormat(format: "H:|-30-[v0]-30-|", views: goToLoginButton)
        container.addContraintsWithFormat(format: "H:|[v0]|", views: legalInfoLabel)
        container.addContraintsWithFormat(format: "H:|[v0]|", views: termsAndConditions)
        container.addContraintsWithFormat(format: "H:|[v0]|", views: privacyPolicy)
        
         termsAndConditions.addTarget(self, action: #selector(goToTermsAndConditions), for: .touchUpInside)
         privacyPolicy.addTarget(self, action: #selector(goToPrivacyPolicy), for: .touchUpInside)
        
    }
    
    
    @objc func buttonPressed() {
        if let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                if email == "" || name == "" || password == "" {
                    let banner = NotificationBanner(title: "Authentication Error!", subtitle: "Please fill the missing text field(s)", leftView: nil, rightView: nil, style: .danger, colors: nil)
                    banner.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: self)
                }
                else if error != nil {
                    let banner = NotificationBanner(title: "Authentication Error!", subtitle: "\(error!.localizedDescription)", leftView: nil, rightView: nil, style: .danger, colors: nil)
                    banner.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: self)
                } else {
                    
                    
                    print("\(authResult!.user) created!")
                    
                    let newUser = User(name: name, userID: authResult!.user.uid , groupID: UUID().uuidString, email: email)
                    
                    self.provider.saveUserData(user: newUser)
                    self.groupProvider.createGroupWithOwner(user: newUser)
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
    
    @objc func goToPrivacyPolicy() {
        let controller = Legal_InfoViewController()
        controller.documentToOpen = "PP"
        self.present(controller, animated: true , completion: nil)
    }
    
    @objc func goToTermsAndConditions() {
        let controller = Legal_InfoViewController()
        controller.documentToOpen = "TC"
        self.present(controller, animated: true , completion: nil)
    }
}
