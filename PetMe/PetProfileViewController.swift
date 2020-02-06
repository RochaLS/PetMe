//
//  PetProfileViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-05.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class PetProfileViewController: UIViewController {
    
    var pet: Pet! {
        didSet {
            navigationItem.title = pet.name
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
    }
    
}
