//
//  RemindersViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-09.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class RemindersViewController: UIViewController {
    
    weak var collectionView: UICollectionView!
    
    let cell_id = "reminderCell"
    
    var provider: ReminderDataProvider! = nil
    
    var reminders = [Reminder]()
    
    
    
    
    let addButton: UIButton = {
        let button = AddButton()
        button.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.backgroundColor
        navigationController?.navigationBar.barTintColor = AppColors.backgroundColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Reminders"
        

        setupViews()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ReminderCollectionViewCell.self, forCellWithReuseIdentifier: cell_id)
        provider = ReminderDataProvider()
        provider.delegate = self
        provider.setReminderData()
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
        
        self.view.addContraintsWithFormat(format: "V:[v0(60)]-\(tabBarController!.tabBar.frame.height + 10)-|", views: addButton)
        self.view.addContraintsWithFormat(format: "H:[v0(60)]-15-|", views: addButton)
    }
    
    @objc func plusButtonPressed() {
        self.present(AddReminderViewController(), animated: true, completion: nil)
    }
    
}
