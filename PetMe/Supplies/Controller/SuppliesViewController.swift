//
//  SuppliesViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-22.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import NotificationCenter

class SuppliesViewController: UIViewController {
    
    var pet: Pet!
    
    let cell_id = "BaseCell"
    
    let titles = ["Favorite Foods", "Favorite Treats", "Favorite Toys"]
    
    weak var collectionView: UICollectionView!
    
    var generalCell: GeneralCell?
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(didTapOnAdd), name: .didTapOnAdd, object: nil)
        
        
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
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.headerView.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor)
        ])
        
        collectionView.backgroundColor = AppColors.backgroundColor
        collectionView.isPagingEnabled = true
        
        self.collectionView = collectionView
        self.collectionView.register(GeneralCell.self, forCellWithReuseIdentifier: cell_id)
    }
    
    @objc func didTapOnAdd(notification: Notification) {
        if let data = notification.userInfo {
            let index = data["index"] as! Int
            
            if index == 0 {
                let controller = CreateFavoriteFoodViewController()
                controller.pet = pet
                self.present(controller, animated: true, completion: nil)
            } else if index == 1 {
                let controller = CreateFavoriteTreatViewController()
                controller.pet = pet
                self.present(controller, animated: true, completion: nil)
            } else if index == 2 {
                let controller = CreateFavoriteToyViewController()
                controller.pet = pet
                self.present(controller, animated: true, completion: nil)
            }
        }
        
    }
    
}
