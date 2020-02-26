//
//  CreateMoodViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-24.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class CreateMoodViewController: UIViewController {
    
    var pet: Pet!
    
    let questionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.boldSystemFont(ofSize: 24)
        textView.text = "Some text"
        textView.textColor = AppColors.black
        textView.textAlignment = .center
        textView.backgroundColor = UIColor.clear
        
        return textView
    }()
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColors.backgroundColor
        setupViews()
    }
    
    func setupViews() {
        let happyButton = ChooseMoodButton()
        happyButton.setTitle("Happy", for: .normal)
        happyButton.backgroundColor = AppColors.green
        
        let sadButton = ChooseMoodButton()
        sadButton.setTitle("Sad", for: .normal)
        sadButton.backgroundColor = AppColors.blue
        
        let sleepyButton = ChooseMoodButton()
        sleepyButton.setTitle("Sleepy", for: .normal)
        sleepyButton.backgroundColor = AppColors.darkBlue
        
        questionTextView.text = "How do you think is \(pet.name) feeling right now?"
        
        view.addSubview(questionTextView)
        
        view.addSubview(container)
        container.addSubview(happyButton)
        container.addSubview(sadButton)
        container.addSubview(sleepyButton)
        

        questionTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        questionTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.addContraintsWithFormat(format: "H:|-10-[v0]-10-|", views: questionTextView)
        view.addContraintsWithFormat(format: "H:|[v0]|", views: container)

   
        container.heightAnchor.constraint(equalToConstant: 250).isActive = true
        container.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        container.addContraintsWithFormat(format: "H:|-40-[v0]-40-|", views: happyButton)
        container.addContraintsWithFormat(format: "H:|-40-[v0]-40-|", views: sadButton)
        container.addContraintsWithFormat(format: "H:|-40-[v0]-40-|", views: sleepyButton)
        container.addContraintsWithFormat(format: "V:|-10-[v0]-20-[v1]-20-[v2]", views: happyButton, sadButton, sleepyButton)

    }

}
