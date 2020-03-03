//
//  VaccineInfoViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-02.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class VaccineInfoViewController: UIViewController {
    
    var vaccine: Vaccine!
    
    weak var tableView: UITableView!
    
    let cell_id = "vaccineInfo_Cell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Vaccine"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = AppColors.primaryColor
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = AppColors.primaryColor
        setupViews()
        setupTableView()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(VaccineInfoTableViewCell.self, forCellReuseIdentifier: cell_id)
        
        self.tableView.tableFooterView = UIView() // Remove extra lines from table view
    }
    
    func setupViews() {
        view.addSubview(titleLabel)
        titleLabel.text = "\(vaccine.name)"
        
        view.addContraintsWithFormat(format: "V:|[v0]", views: titleLabel)
        view.addContraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
    }
    
    func setupTableView() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        
        
        NSLayoutConstraint.activate([
            self.titleLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20),
            self.view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            self.view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            self.view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor)
        ])
        
        self.tableView = tableView
        tableView.backgroundColor = UIColor.white
        
    }
    
}
