//
//  PetProfileViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-05.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class PetProfileViewController: UIViewController, DataProviderDelegate {
    
    weak var collectionView: UICollectionView!
    
    let cell_id = "button_cell_id"
    
    var provider: DataManager! = nil
    
    var pet: Pet!
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentSize.height = view.frame.height
        view.backgroundColor = AppColors.primaryColor
        
        return view
    }()
    
    
    let topContainer: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.primaryColor
        return view
    }()
    
    let bottomContainer: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.backgroundColor
        
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    
    let petAvatarPic: UIImageView = PetAvatarWithBorderImageView()
    
    let petNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pet Name"
        label.font = AppFonts.mainFontBold
        label.font = label.font.withSize(26)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    var avatarRawImage: UIImage?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.barTintColor = AppColors.backgroundColor
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        // apple default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.barTintColor = AppColors.primaryColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provider = DataManager()
        provider.delegate = self
        
        
        setupViews()
        setupCollectionView()
        
        self.navigationController?.navigationBar.barTintColor = AppColors.primaryColor
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.collectionView.register(ProfileButtonCollectionViewCell.self, forCellWithReuseIdentifier: cell_id)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        if view.frame.height <= 568 {
            self.collectionView.isScrollEnabled = true
        } else {
            self.collectionView.isScrollEnabled = false
        }
        
        
        if view.frame.height > 736 { // iphone 8 plus screen height
            scrollView.isScrollEnabled = false
        }
        
        
        petAvatarPic.image = UIImage(named: "placeholder")
        
        
        provider.getPetImageToImageView(from: pet, to: petAvatarPic)
    }
    
    func setupCollectionView() {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomContainer.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.topContainer.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10),
            self.bottomContainer.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            self.bottomContainer.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            self.bottomContainer.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])
        
        self.collectionView = collectionView
        
        //Customize collectionView from here:
        
        self.collectionView.backgroundColor = AppColors.backgroundColor
        
    }
    
    func setupViews() {
        
        view.backgroundColor = AppColors.backgroundColor
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topContainer)
        contentView.addSubview(bottomContainer)
        
        
        view.addContraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        view.addContraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        scrollView.addContraintsWithFormat(format: "V:|[v0]|", views: contentView)
        scrollView.addContraintsWithFormat(format: "H:|[v0]|", views: contentView)
        
        scrollView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: scrollView, attribute: .centerX, multiplier: 1, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: scrollView, attribute: .centerY, multiplier: 1, constant: 0))
        
        topContainer.addSubview(petAvatarPic)
        topContainer.addSubview(petNameLabel)
        
        
        contentView.addContraintsWithFormat(format: "H:|[v0]|", views: topContainer)
        contentView.addContraintsWithFormat(format: "V:|[v0(250)][v1]|", views: topContainer, bottomContainer)
        contentView.addContraintsWithFormat(format: "H:|[v0]|", views: bottomContainer)
        
        topContainer.addContraintsWithFormat(format: "H:[v0(150)]", views: petAvatarPic)
        topContainer.addContraintsWithFormat(format: "V:|-30-[v0(150)]-15-[v1]", views: petAvatarPic, petNameLabel)
        topContainer.addContraintsWithFormat(format: "H:|[v0]|", views: petNameLabel)
        
        
        topContainer.addConstraint(NSLayoutConstraint(item: petAvatarPic, attribute: .centerX, relatedBy: .equal, toItem: topContainer, attribute: .centerX, multiplier: 1, constant: 0))
        
        
        petNameLabel.text = pet.name
        
    }
    
    func didLoadImage(image: UIImage, reference: UIImageView) {
        let resizedImage = image.circle
        reference.image = resizedImage
        avatarRawImage = resizedImage
    }
}
