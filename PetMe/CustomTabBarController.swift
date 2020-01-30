//
//  CustomTabBarController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-01-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let layout = UICollectionViewFlowLayout()
        let allPetsController = AllPetsController()
        let allPetsNavController = UINavigationController(rootViewController: allPetsController)
        allPetsController.tabBarItem.title = "My pets"
        allPetsController.tabBarItem.image = UIImage(named: "pets")
        tabBar.tintColor = UIColor(rgb: 0x333333)
        
        
        viewControllers = [allPetsNavController]
        
    }

}
