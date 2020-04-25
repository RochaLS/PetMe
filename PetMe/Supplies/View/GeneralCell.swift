//
//  GeneralCell.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-25.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class GeneralCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellID = "ContentCellID"
    var pageTitle = "Favorite Foods"

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
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
        backgroundColor = .brown
        
        addSubview(collectionView)
        addContraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        addContraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        
        collectionView.register(FavoriteFoodsWithImageCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headView")
        
        NotificationCenter.default.addObserver(self, selector: #selector(changePageTitle), name: .willChangePageTitle, object: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID , for: indexPath) as! FavoriteFoodsWithImageCell
        cell.setupViews()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: frame.width - 20, height: 300)
    }
    
    
    //     For header size (required)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width:collectionView.frame.size.width, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headView", for: indexPath) as! HeaderCollectionReusableView
            
            
            headView.titleLabel.text = pageTitle
            return headView
            
        default:
            
            fatalError("Unexpected element kind")
        }
    }
    
    
    @objc func changePageTitle(notification: Notification) {
        if let data = notification.userInfo as? [String:String] {
            pageTitle = data["title"]!
            collectionView.reloadData()
        }
    }
}
