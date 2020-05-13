//
//  NetworkManager.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-05-11.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import Network
import NotificationBannerSwift

class NetworkManager {
    
    static var monitor = NWPathMonitor()
    
    static func changeViewBasedOnNetworkStatus(navigationController: UINavigationController, buttonsToDisable buttons: [UIButton], status: Bool, bannerToShow banner: StatusBarNotificationBanner, completion: (() -> Void)) {
        
        if status == false {
            
            for button in buttons {
                button.isEnabled = false
            }
            banner.autoDismiss = false
            banner.show()
            navigationController.navigationBar.barStyle = .black
        }
        completion()
    }
}
