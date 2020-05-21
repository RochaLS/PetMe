//
//  RemindersViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-09.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftSpinner

class RemindersViewController: UIViewController {
    
    weak var collectionView: UICollectionView!
    let cell_id = "reminderCell"
    var provider: ReminderDataProvider! = nil
    var userDataProvider: UserDataProvider! = nil
    var reminders = [Reminder]()
    var currentUserGroupID: String?
    
    
    
    
    let addButton: UIButton = {
        let button = AddButton()
        button.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        return button
        
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap on [+] to add a reminder!"
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        return label
    }()
    
    override func loadView() {
        super.loadView()
        SwiftSpinner.show("Loading", animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.backgroundColor
        navigationController?.navigationBar.barTintColor = AppColors.backgroundColor
        navigationController?.navigationBar.shadowImage = UIImage()
           self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 20)!]
        navigationItem.title = "Reminders"
        

        setupViews()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ReminderCollectionViewCell.self, forCellWithReuseIdentifier: cell_id)
        provider = ReminderDataProvider()
        provider.delegate = self
        userDataProvider = UserDataProvider()
        userDataProvider.delegate = self
        
        let currentUser = Auth.auth().currentUser
        
        if currentUser != nil {
            userDataProvider.getUserGroupID(userID: currentUser!.uid)
        }
        
        SwiftSpinner.hide()
    }
    
    func setupViews() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])
        
        collectionView.backgroundColor = AppColors.backgroundColor
        
        self.collectionView = collectionView
        
        self.view.addSubview(addButton)
        self.view.addSubview(infoLabel)
        
        self.view.addContraintsWithFormat(format: "V:[v0(60)]-\(tabBarController!.tabBar.frame.height + 10)-|", views: addButton)
        self.view.addContraintsWithFormat(format: "H:[v0(60)]-15-|", views: addButton)
        self.view.addContraintsWithFormat(format: "V:|[v0]|", views: infoLabel)
        self.view.addContraintsWithFormat(format: "H:|[v0]|", views: infoLabel)
    }
    
    @objc func plusButtonPressed() {
        let controller = AddReminderViewController()
        controller.currentUserGroupID = currentUserGroupID!
        self.present(controller, animated: true, completion: nil)
    }
    
}
