//
//  GeneralCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-25.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import Firebase
import PMAlertController
import SwiftSpinner

class GeneralCell: BasicCollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellID = "FavoriteCellID"
    let treatsCellID = "TreatsCellID"
    let toysCellID = "ToysCellID"
    var pageTitle = "Favorite Foods"
    var currentIndex: Int = 0
    var provider = SuppliesDataProvider()
    var foods = [Food]()
    var treats = [Treat]()
    var toys = [Toy]()
    var petID: String!
    weak var suppliesRef: SuppliesViewController!
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap on [Add] to add a new item!"
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        label.font = AppFonts.mainFontMedium
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setData()
        
        provider.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    
    func setupViews() {
        self.collectionView.backgroundColor = AppColors.backgroundColor
        
        addSubview(collectionView)
        addSubview(infoLabel)
        
        addContraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        addContraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addContraintsWithFormat(format: "V:|[v0]|", views: infoLabel)
        addContraintsWithFormat(format: "H:|[v0]|", views: infoLabel)
        
        collectionView.register(FavoriteFoodsWithImageCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(TreatsCell.self, forCellWithReuseIdentifier: treatsCellID)
        collectionView.register(ToyCell.self, forCellWithReuseIdentifier: toysCellID)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headView")
        
        NotificationCenter.default.addObserver(self, selector: #selector(changePageTitle), name: .willChangePageTitle, object: nil)
        
    }
    
    func setData() {
        if currentIndex == 0 {
            provider.getFoodData(petID: GlobalVariables.petID)
        } else if currentIndex == 1 {
            provider.getTreatData(petID: GlobalVariables.petID)
        } else if currentIndex ==  2 {
            provider.getToyData(petID: GlobalVariables.petID)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currentIndex == 0 {
            return foods.count
        } else if currentIndex == 1 {
            return treats.count
        } else if currentIndex == 2 {
            return toys.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if currentIndex == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID , for: indexPath) as! FavoriteFoodsWithImageCell
            
            if foods.count > 0 {
                infoLabel.isHidden = true
            }
            
            cell.brandAnswer.text = foods[indexPath.item].brand
            cell.breedSizeAnswer.text = foods[indexPath.item].breedSize
            cell.flavourAnswer.text = foods[indexPath.item].flavour
            cell.typeAnswer.text = foods[indexPath.item].type
            cell.setupFood(food: foods[indexPath.item])
            cell.delegate = self
            provider.getSupplyImage(of: foods[indexPath.item].imgName, to: cell.petImageView, typeOfSupply: "foods")
            
            return cell
            
        } else if currentIndex == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: treatsCellID, for: indexPath) as! TreatsCell
            
            if treats.count > 0 {
                infoLabel.isHidden = true
            }
            
            cell.brandAnswer.text = treats[indexPath.item].brand
            cell.nameAnswer.text = treats[indexPath.item].name
            cell.setupTreat(treat: treats[indexPath.item])
            cell.delegate = self
            provider.getSupplyImage(of: treats[indexPath.item].imgName, to: cell.petImageView, typeOfSupply: "treats")
            
            return cell
        } else if currentIndex == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: toysCellID , for: indexPath) as! ToyCell
            
            if toys.count > 0 {
                infoLabel.isHidden = true
            }
            
            cell.nameAnswer.text = toys[indexPath.item].name
            cell.setupToy(toy: toys[indexPath.item])
            cell.delegate = self
            provider.getSupplyImage(of: toys[indexPath.item].imgName, to: cell.petImageView, typeOfSupply: "toys")
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if currentIndex == 0 {
            return CGSize(width: frame.width - 20, height: 300)
        } else if currentIndex == 1 {
            return CGSize(width:frame.width - 20 , height: 260)
        } else {
            return CGSize(width:frame.width - 20 , height: 220)
        }
    }
    
    
    //     For header size (required)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width:collectionView.frame.size.width, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headView", for: indexPath) as! HeaderCollectionReusableView
            
            headView.addButton.addTarget(self, action: #selector(goToCreateItem), for: .touchUpInside)
            headView.titleLabel.text = pageTitle
            return headView
            
        default:
            
            fatalError("Unexpected element kind")
        }
    }
    
    
    @objc func changePageTitle(notification: Notification) {
        if let data = notification.userInfo as? [String:Any] {
            pageTitle = data["title"] as! String
            currentIndex = data["index"] as! Int
            suppliesRef = data["suppliesRef"] as? SuppliesViewController
            setData()
        }
        
    }
    
    @objc func goToCreateItem() {
        NotificationCenter.default.post(name: .didTapOnAdd, object: nil, userInfo: ["index":currentIndex])
    }
}

