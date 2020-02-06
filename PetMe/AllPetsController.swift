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
    
    private let cell_id = "pet_cell"
    
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



extension AllPetsController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = pets?.count {
            print(count)
            return count
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_id , for: indexPath) as! PetCell
        
        if let pet = pets?[indexPath.row] {
            cell.nameLabel.text = pet.name
            cell.dogImageView.image = UIImage(named: pets![indexPath.row].imgName!)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //top, left, bottom, right
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = PetProfileViewController()
        controller.pet = pets?[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @objc func reloadCollectionView() {
        loadData()
        collectionView.reloadData()
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

extension Notification.Name {
    static let didAddNewPet = Notification.Name("didAddNewPet")
}
