//
//  GroupViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-30.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {
    
    weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = AppColors.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 20)!]
        navigationItem.title = "My Group"
        setupViews()
    }
    
    
    func setupViews() {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView() // Use this to remove extra tableview separators
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "GroupCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        
        
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: tableView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            self.view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            self.view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor)
        ])
        
        self.tableView = tableView
        
    }
    
}
