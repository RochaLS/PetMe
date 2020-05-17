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
    static var noNetwork = StatusBarNotificationBanner(title: "No internet connection! Try again later!", style: .danger, colors: nil)
    static var noNetworkLarge = NotificationBanner(title: "No internet connection!", subtitle: "Please check your network and try again! Tap to dismiss! ", leftView: nil, rightView: nil, style: .danger, colors: nil)
    
    static func showBottomBanner(on vc: UIViewController?) {
        Banners.noNetworkLarge.duration = 5

        if vc != nil {
            Banners.noNetworkLarge.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: vc)
        } else {
            Banners.noNetworkLarge.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: nil)
        }
        
    }
    
    static func showTopBanner(on vc: UIViewController?) {
        Banners.noNetworkLarge.duration = 5
        if vc != nil {
            Banners.noNetworkLarge.show(queuePosition: .front, bannerPosition: .top, queue: .default, on: vc!)
        } else {
            Banners.noNetworkLarge.show(queuePosition: .front, bannerPosition: .top, queue: .default, on: nil)
        }
        
    }
    
    static func showStatusBanner(on vc: UINavigationController?, completion: (() -> Void)?) {
        if vc != nil {
            Banners.noNetwork.show(queuePosition: .front, bannerPosition: .top, queue: .default, on: vc)
            vc!.navigationBar.overrideUserInterfaceStyle = .dark
//            vc!.setNeedsStatusBarAppearanceUpdate()
        } else {
            Banners.noNetwork.show(queuePosition: .front, bannerPosition: .top, queue: .default, on: nil)
        }
         
        if completion != nil {
           completion!()
        }
        
    }
    
}
