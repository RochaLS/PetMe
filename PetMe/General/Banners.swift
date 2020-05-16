//
//  Banners.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-05-13.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class Banners {
    static var noNetwork = StatusBarNotificationBanner(title: "No internet connection!", style: .danger, colors: nil)
    static var noNetworkLarge = NotificationBanner(title: "No internet connection!", subtitle: "Please check your network and try again! ", leftView: nil, rightView: nil, style: .danger, colors: nil)
    
    static func showBottomBanner(on vc: UIViewController?) {
        Banners.noNetworkLarge.duration = 20
        if vc != nil {
            Banners.noNetworkLarge.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: vc)
        } else {
            Banners.noNetworkLarge.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: nil)
        }
        
    }
    
    static func showTopBanner(on vc: UIViewController?) {
        Banners.noNetworkLarge.duration = 20
        if vc != nil {
            Banners.noNetworkLarge.show(queuePosition: .front, bannerPosition: .top, queue: .default, on: vc!)
        } else {
            Banners.noNetworkLarge.show(queuePosition: .front, bannerPosition: .top, queue: .default, on: nil)
        }
        
    }
    
}
