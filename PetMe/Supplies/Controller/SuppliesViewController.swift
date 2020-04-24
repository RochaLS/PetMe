//
//  SuppliesViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-22.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class SuppliesViewController: UIViewController {
    
    var pet: Pet!
    
    let cell_id = "Supply_Cell"
    
    weak var collectionView: UICollectionView!
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.primaryColor
        return view
    }()
    
    let petImageView: UIImageView = PetAvatarImageView()
    
    let titleText: UILabel = {
        let label = UILabel()
        label.font = AppFonts.mainFontMedium
        label.font = label.font.withSize(22)
        label.textColor = UIColor.white
        return label
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.barTintColor = AppColors.primaryColor
        navigationController?.navigationBar.tintColor = UIColor.white
        self.view.backgroundColor = AppColors.backgroundColor
        self.navigationItem.title = "Info and Supplies"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 22)!]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
        setupCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupView() {
        view.addSubview(headerView)
        headerView.addSubview(petImageView)
        headerView.addSubview(titleText)
        
        
        petImageView.backgroundColor = UIColor.red
        petImageView.image = UIImage(named: pet.imgName!)
        petImageView.layer.borderWidth = 2
        petImageView.layer.borderColor = AppColors.backgroundColor.cgColor
        titleText.text = pet.name
        
        view.addContraintsWithFormat(format: "V:|[v0(130)]", views: headerView)
        view.addContraintsWithFormat(format: "H:|[v0]|", views: headerView)
        headerView.addContraintsWithFormat(format: "V:[v0(68)]", views: petImageView)
        headerView.addContraintsWithFormat(format: "H:|-20-[v0(68)]-15-[v1]", views: petImageView, titleText)
        headerView.addContraintsWithFormat(format: "V:|[v0]|", views: titleText)
        
        //Center:
        
        headerView.addConstraint(NSLayoutConstraint(item: petImageView, attribute: .centerY, relatedBy: .equal, toItem: headerView, attribute: .centerY, multiplier: 1, constant: 0))
        
        headerView.addConstraint(NSLayoutConstraint(item: titleText, attribute: .centerY, relatedBy: .equal, toItem: headerView, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    func setupCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.headerView.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor)
        ])
        
        collectionView.backgroundColor = AppColors.backgroundColor
        collectionView.layer.cornerRadius = 8
        //        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.collectionView = collectionView
        self.collectionView.register(FavoriteFoodsWithImageCell.self, forCellWithReuseIdentifier: cell_id)
        self.collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headView")
    }
    
}
