//
//  ViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-01-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FirebaseAuth

class AllPetsController: UIViewController {
    
    weak var collectionView: UICollectionView!
    
    var provider: DataManager! = nil
    var userDataProvider: UserDataProvider! = nil
    let cell_id = "pet_cell"
    var pets = [Pet]()
    var petImage: UIImage!
    var currentUserGroupID: String?
    
    
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        provider = DataManager()
        userDataProvider = UserDataProvider()
        userDataProvider.delegate = self
        
        provider.delegate = self
        
        let currentUser = Auth.auth().currentUser
        
        if currentUser != nil {
            userDataProvider.getUserGroupID(userID: currentUser!.uid)
        }
        
        
        //        setupData()
        
        navigationItem.title = "My Pets"
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(PetCell.self, forCellWithReuseIdentifier: cell_id )
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = AppColors.backgroundColor
        
        self.navigationController?.navigationBar.barTintColor = AppColors.backgroundColor
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 20)!]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    let addButton: UIButton = {
        let button = AddButton()
        button.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        return button
        
    }()
    
    func setupViews() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])
        self.collectionView = collectionView
        
        self.view.addSubview(addButton)
        
        self.view.addContraintsWithFormat(format: "V:[v0(60)]-\(tabBarController!.tabBar.frame.height + 10)-|", views: addButton)
        self.view.addContraintsWithFormat(format: "H:[v0(60)]-15-|", views: addButton)
        
    }
    
    @objc func plusButtonPressed() {
        let addPetViewController = AddPetViewController()
        if currentUserGroupID != nil {
            addPetViewController.currentUserGroupID = currentUserGroupID!
        }
        self.present(addPetViewController, animated: true, completion: nil)
    }
}




