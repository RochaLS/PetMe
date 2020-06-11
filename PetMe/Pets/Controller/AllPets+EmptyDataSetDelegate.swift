//
//  Allpets+EmptyDataSetDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-06-10.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import DZNEmptyDataSet
import UIKit

extension AllPetsController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "It seems like you didn't add any pets yet..."
        let attrs = [NSAttributedString.Key.font: AppFonts.mainFontMedium]
        return NSAttributedString(string: str, attributes: attrs as [NSAttributedString.Key : Any])
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Tap on (+) to add a new pet!"
        let attrs = [NSAttributedString.Key.font: AppFonts.mainFontMedium]
        
        return NSAttributedString(string: str, attributes: attrs as [NSAttributedString.Key : Any])
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return provider.pets.isEmpty
    }
}
