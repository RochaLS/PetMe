//
//  SuppliesViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-22.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import NotificationCenter
import PMAlertController

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
    
    var avatarRawImage: UIImage?
    
    var provider: SuppliesDataProvider!
    
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
        provider = SuppliesDataProvider()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didTapOnAdd), name: .didTapOnAdd, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willShowAlert), name: .willShowAlert, object: nil)
        
        GlobalVariables.petID = pet.id
        
        
    }
    
    func setupView() {
        view.addSubview(headerView)
        headerView.addSubview(petImageView)
        headerView.addSubview(titleText)
        
        
        if avatarRawImage != nil {
            petImageView.image = avatarRawImage
        } else {
            petImageView.image = UIImage(named: "placeholder")
        }
        
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
    
    @objc func willShowAlert(notification: Notification) {
        if let data = notification.userInfo {
            if let foodToRemove = data["itemToRemove"] as? Food {
                showAlertToRemoveFood(itemToRemove: foodToRemove)
            } else if let treatToRemove = data["itemToRemove"] as? Treat {
                showAlertToRemoveTreat(itemToRemove: treatToRemove)
            } else if let toyToRemove = data["itemToRemove"] as? Toy {
                showAlertToRemoveToy(itemToRemove: toyToRemove)
            }
            
        }
    }
    
    
    // MARK: - Refactor this later ....
    
    func showAlertToRemoveFood(itemToRemove: Food) {
        let alertVC = PMAlertController(title: "Remove this item?", description: "Are you sure you want to remove this item?", image: nil, style: .alert)
        
        alertVC.alertTitle.font = AppFonts.mainFontMedium
        alertVC.alertTitle.font = alertVC.alertTitle.font.withSize(22)
        alertVC.alertTitle.textColor = AppColors.black
        
        alertVC.alertDescription.font = AppFonts.mainFontRegular
        alertVC.alertDescription.font = alertVC.alertDescription.font.withSize(18)
        
        
        
        
        
        alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () -> Void in
            print("cancel pressed")
        }))
        
        let confirmAction = PMAlertAction(title: "Confirm", style: .default, action: { () in
            self.provider.deleteFood(food: itemToRemove)
            self.collectionView.reloadData()
        })
        
        confirmAction.setTitleColor(AppColors.red, for: .normal)
        
        alertVC.addAction(confirmAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showAlertToRemoveTreat(itemToRemove: Treat) {
        let alertVC = PMAlertController(title: "Remove this item?", description: "Are you sure you want to remove this item?", image: nil, style: .alert)
        
        alertVC.alertTitle.font = AppFonts.mainFontMedium
        alertVC.alertTitle.font = alertVC.alertTitle.font.withSize(22)
        alertVC.alertTitle.textColor = AppColors.black
        
        alertVC.alertDescription.font = AppFonts.mainFontRegular
        alertVC.alertDescription.font = alertVC.alertDescription.font.withSize(18)
        
        
        
        
        
        alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () -> Void in
            print("cancel pressed")
        }))
        
        let confirmAction = PMAlertAction(title: "Confirm", style: .default, action: { () in
            self.provider.deleteTreat(treat: itemToRemove)
            self.collectionView.reloadData()
        })
        
        confirmAction.setTitleColor(AppColors.red, for: .normal)
        
        alertVC.addAction(confirmAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showAlertToRemoveToy(itemToRemove: Toy) {
        let alertVC = PMAlertController(title: "Remove this item?", description: "Are you sure you want to remove this item?", image: nil, style: .alert)
        
        alertVC.alertTitle.font = AppFonts.mainFontMedium
        alertVC.alertTitle.font = alertVC.alertTitle.font.withSize(22)
        alertVC.alertTitle.textColor = AppColors.black
        
        alertVC.alertDescription.font = AppFonts.mainFontRegular
        alertVC.alertDescription.font = alertVC.alertDescription.font.withSize(18)
        
        
        
        
        
        alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel, action: { () -> Void in
            print("cancel pressed")
        }))
        
        let confirmAction = PMAlertAction(title: "Confirm", style: .default, action: { () in
            self.provider.deleteToy(toy: itemToRemove)
            self.collectionView.reloadData()
        })
        
        confirmAction.setTitleColor(AppColors.red, for: .normal)
        
        alertVC.addAction(confirmAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
}
