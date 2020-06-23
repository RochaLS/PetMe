//
//  CustomTabBarController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-01-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    var cameFromNotification: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let layout = UICollectionViewFlowLayout()
//        let allPetsController = AllPetsController()
//        let allPetsNavController = UINavigationController(rootViewController: allPetsController)
//        let remindersController = RemindersViewController()
//        let remindersNavController = UINavigationController(rootViewController: remindersController)
//        remindersController.tabBarItem.title = "Reminders"
//        remindersController.tabBarItem.image = UIImage.fontAwesomeIcon(name: .listAlt, style: .regular, textColor: AppColors.black, size: CGSize(width: 35, height: 35))
//        allPetsController.tabBarItem.title = "My pets"
//        allPetsController.tabBarItem.image = UIImage.fontAwesomeIcon(name: .paw, style: .solid, textColor: AppColors.black, size: CGSize(width: 35, height: 35))
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveReminderNotification), name: .didReceiveReminderNotif, object: nil)
        tabBar.tintColor = AppColors.black
        viewControllers = [
            createNavControllerWithTitle(title: "My Pets", img: UIImage.fontAwesomeIcon(name: .paw, style: .solid, textColor: AppColors.black, size: CGSize(width: 35, height: 35)), controller: AllPetsController()),
            createNavControllerWithTitle(title: "Reminders", img: UIImage.fontAwesomeIcon(name: .listAlt, style: .regular, textColor: AppColors.black, size: CGSize(width: 35, height: 35)), controller: RemindersViewController()),
            createNavControllerWithTitle(title: "Settings", img: UIImage.fontAwesomeIcon(name: .cog, style: .solid, textColor: AppColors.black, size: CGSize(width: 35, height: 35)), controller: SettingsViewController())]
        
        
    }
    
     func createNavControllerWithTitle(title: String, img: UIImage, controller: UIViewController) -> UINavigationController {
        let viewController = controller
        let navController = UINavigationController(rootViewController: viewController)
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = img
        
        return navController
    }
    
    @objc func didReceiveReminderNotification(notification: Notification) {
    
        if let data = notification.userInfo {
            if let isReminderNotif = data["reminderNotif"] as? Bool {
                if isReminderNotif {
                    self.selectedIndex = 1
                } else {
                    self.selectedIndex = 2
                    let controller = InvitesViewController()
                    controller.cameFromNotification = true
                    self.present(controller, animated: true, completion: nil)
                }
            }
        }
        
    }

}
