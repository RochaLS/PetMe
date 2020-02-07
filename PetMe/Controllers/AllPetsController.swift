//
//  ViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-01-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import CoreData

class AllPetsController: UIViewController {
    
    weak var collectionView: UICollectionView!
    
    let cell_id = "pet_cell"
    
    var pets: [Pet]?
    
    
    
    override func loadView() {
        super.loadView()
        
        setupViews()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        
        navigationItem.title = "My Pets"
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(PetCell.self, forCellWithReuseIdentifier: cell_id )
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = UIColor(rgb: 0xF6F6F6)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: .didAddNewPet, object: nil)
    }
    
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0x21bf73)
        button.layer.cornerRadius = 30
        button.setImage(UIImage(named: "add")?.withTintColor(UIColor.white), for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.3
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
        self.present(addPetViewController, animated: true, completion: nil)
    }
}




