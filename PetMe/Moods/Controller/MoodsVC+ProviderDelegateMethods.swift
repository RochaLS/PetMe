//
//  MoodsVC+ProviderDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-25.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import SwiftSpinner

extension MoodsViewController: MoodDataProviderDelegate {
    
    func didAddNewMood() {
        self.collectionView.reloadData()
        SwiftSpinner.hide()
    }
    
    func didLoadMoodData(allMoods: [Mood]) {
        moods = allMoods
        self.collectionView.reloadData()
        SwiftSpinner.hide()
    }
    
    
}
