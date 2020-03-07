//
//  MoodDataProviderDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-25.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

protocol MoodDataProviderDelegate: class {
    
    func didLoadMoodData(allMoods: [Mood])
}
