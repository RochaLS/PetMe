//
//  AttrStringHelper.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-30.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class AttrStringHelper {
    static func createStringWithIcon(word: String, fontAwesomeIconToAppend: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let string =  NSMutableAttributedString(string: "\(fontAwesomeIconToAppend) ", attributes: [.font: UIFont.fontAwesome(ofSize: 24, style: .solid), .foregroundColor: AppColors.primaryColor]  )
          
      string.append(NSAttributedString(string: word, attributes: [NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: fontSize)!, NSAttributedString.Key.foregroundColor: AppColors.black]
          ))
          
          return string
      }
}
