//
//  GeneralHelper.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-28.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class GeneralHelper {
    static func createAttrString(word: String, fontAwesomeIconToAppend: String) -> NSMutableAttributedString {
         let string =  NSMutableAttributedString(string: "\(fontAwesomeIconToAppend) ", attributes:         [.font: UIFont.fontAwesome(ofSize: 24, style: .solid)]  )
         
         string.append(NSAttributedString(string: word, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .medium), NSAttributedString.Key.foregroundColor: AppColors.black]
         ))
         
         return string
     }
}
