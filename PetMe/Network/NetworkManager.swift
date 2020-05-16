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
    
    static func changeViewBasedOnNetworkStatus(vc: UIViewController?, navigationController: UINavigationController?, buttonsToDisable buttons: [UIButton]?, status: Bool, bannerToShow banner: BaseNotificationBanner, completion: (() -> Void)) {
        
        if status == false {
            
            if let buttonsArray = buttons {
                for button in buttonsArray {
                    button.isEnabled = false
                }
            }
            
            banner.autoDismiss = false
            
            if vc != nil {
                banner.show(on: vc!)
            } else {
                banner.show()
            }
            
            if navigationController != nil {
                navigationController!.navigationBar.barStyle = .black
            }
        }
        completion()
    }
    
    func showBottomBanner() {
        
    }
}
