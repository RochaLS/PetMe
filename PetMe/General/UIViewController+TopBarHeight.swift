//
//  UIViewController+TopBarHeight.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-31.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

extension UIViewController {

    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */

    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
