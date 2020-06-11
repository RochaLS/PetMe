//
//  MoodsViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-21.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import SwiftSpinner
import DZNEmptyDataSet

class MoodsViewController: UIViewController {
    
    var pet: Pet!
    
    var moods = [Mood]()
    
    weak var collectionView: UICollectionView!
    
    let cell_id = "mood_cell"
    
    var provider: MoodDataProvider! = nil
    
    let addButton: UIButton = {
        let button = AddButton()
        button.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        return button
        
    }()
    
    override func loadView() {
        super.loadView()
        SwiftSpinner.show("Loading", animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Moods History"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 22)!]
        view.backgroundColor = AppColors.backgroundColor
        
        setupViews()
        
        
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.emptyDataSetSource = self
        self.collectionView.emptyDataSetDelegate = self
        
        self.collectionView.register(MoodCollectionViewCell.self, forCellWithReuseIdentifier: cell_id)
        provider = MoodDataProvider()
        provider.delegate = self
        
        provider.setMoodData(pet: pet)
        SwiftSpinner.hide()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.barTintColor = AppColors.primaryColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
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
        let vc = CreateMoodViewController()
        vc.pet = self.pet
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
