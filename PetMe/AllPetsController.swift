//
//  ViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-01-27.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class AllPetsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cell_id = "pet_cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = UIColor(rgb: 0xE5E5E5)
        navigationItem.title = "All Pets"
        
        collectionView.register(PetCell.self, forCellWithReuseIdentifier: cell_id)
        collectionView.alwaysBounceVertical = true
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_id , for: indexPath) as! PetCell
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //top, left, bottom, right
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }


}

class PetCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Drika"
        label.textColor = UIColor(rgb: 0x50D890)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        return label
        
    }()
    
    let dogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 34
        
        return imageView
    }()
    
    func setupViews() {
        
        addSubview(nameLabel)
        addSubview(dogImageView)
        
        dogImageView.image = UIImage(named: "drika")
        
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
//        addContraintsWithFormat(format: "H:|-12-[v0(68)]", views: dogImageView)
        addContraintsWithFormat(format: "V:[v0(68)]", views: dogImageView)
        
        //Center ImageView:
        
        addConstraint(NSLayoutConstraint(item: dogImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addContraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addContraintsWithFormat(format: "H:|-12-[v0(68)]-20-[v1]|", views: dogImageView, nameLabel)
    }
}

extension PetCell {
    func addContraintsWithFormat(format: String, views: UIView...) {

           var viewsDictionary = [String:UIView]()

           for (index, view) in views.enumerated() {
               let key = "v\(index)"
               viewsDictionary[key] = view
               view.translatesAutoresizingMaskIntoConstraints = false
           }

           // Better to write code below just once ;)
           addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: .init(), metrics: nil, views: viewsDictionary))
       }
}

//MARK: - UIColor Extension

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

