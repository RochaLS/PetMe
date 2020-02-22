//
//  MoodsViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-21.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class MoodsViewController: UIViewController {
    
    var pet: Pet!
    
    weak var collectionView: UICollectionView!
    
    let cell_id = "mood_cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Moods History"
        view.backgroundColor = AppColors.backgroundColor
        
        setupCollectionView()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
           self.collectionView.register(MoodCollectionViewCell.self, forCellWithReuseIdentifier: cell_id)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.barTintColor = AppColors.primaryColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setupCollectionView() {
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
        
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
