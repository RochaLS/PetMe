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
        tabBar.tintColor = AppColors.black
        
        
        viewControllers = [allPetsNavController]
        
    }
    
    private func createNavControllerWithTitle(title: String, imgName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imgName)
        
        return navController
    }

}
