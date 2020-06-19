//
//  LoginViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-13.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseInstanceID
import NotificationBannerSwift

class LoginViewController: UIViewController {
    
    var centerConstraint: NSLayoutConstraint?
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = AppFonts.mainFontBold
        label.font = label.font.withSize(22)
        label.textAlignment = .center
        label.textColor = AppColors.black
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = DefaultTextField()
        textField.placeholder = "E-mail"
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = DefaultTextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = DefaultButton()
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    let goToSignUpButton: UIButton = {
        let button = DefaultButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(AppColors.primaryColor, for: .normal)
        button.addTarget(self, action: #selector(goToSignUpPressed), for: .touchUpInside)
        return button
    }()
    
    var provider: UserDataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Auth.auth().currentUser?.email)
        
        provider = UserDataProvider()
        
        view.backgroundColor = UIColor.white
        setupViews()
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveReminderNotif), name: .didReceiveReminderNotif, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if provider.isLogged() {
            self.provider.goToPets(from: self)
        }
    }
    
    func setupViews() {
        view.addSubview(container)
        
        
        centerConstraint = NSLayoutConstraint(item: container, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        
        view.addConstraint(centerConstraint!)
        
        
        
        view.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: container)
        view.addContraintsWithFormat(format: "V:[v0(500)]" , views: container)
        
        container.addSubview(titleLabel)
        container.addSubview(emailTextField)
        container.addSubview(passwordTextField)
        container.addSubview(loginButton)
        container.addSubview(goToSignUpButton)
        
        container.addContraintsWithFormat(format: "V:|-10-[v0][v1(50)]-30-[v2(50)]-60-[v3(60)]-10-[v4(50)]|", views: titleLabel, emailTextField, passwordTextField, loginButton, goToSignUpButton )
        container.addContraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        container.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: emailTextField)
        container.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: passwordTextField)
        container.addContraintsWithFormat(format: "H:|-20-[v0]-20-|", views: loginButton)
        container.addContraintsWithFormat(format: "H:|-30-[v0]-30-|", views: goToSignUpButton)
    }
    
    
    @objc func buttonPressed() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                if email == "" || password == "" {
                    let banner = NotificationBanner(title: "Authentication Error!", subtitle: "Please fill the missing text field(s)", leftView: nil, rightView: nil, style: .danger, colors: nil)
                    banner.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: self)
                } else if error != nil {
                    let banner = NotificationBanner(title: "Authentication Error!", subtitle: "\(error!.localizedDescription)", leftView: nil, rightView: nil, style: .danger, colors: nil)
                    banner.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: self)
                    print(error!)
                }
                
                if authResult != nil {
                    self.provider.goToPets(from: self)
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                }
                
            }
            let instance = InstanceID.instanceID()
            instance.deleteID { (error) in
                print(error.debugDescription)
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
    
    @objc func goToSignUpPressed() {
        
        let controller = SignUpViewController()
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
    @objc func didReceiveReminderNotif() {
        self.provider.goToReminders(from: self)
    }
}
