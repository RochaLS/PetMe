//
//  RemindersVC+EmptyDataSetDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-06-10.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

extension RemindersViewController: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "You have no new reminders."
        let attrs = [NSAttributedString.Key.font: AppFonts.mainFontMedium]
        return NSAttributedString(string: str, attributes: attrs as [NSAttributedString.Key : Any])
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Tap on (+) to add a new reminder!"
        let attrs = [NSAttributedString.Key.font: AppFonts.mainFontMedium]
        
        return NSAttributedString(string: str, attributes: attrs as [NSAttributedString.Key : Any])
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return reminders.isEmpty
    }
}
