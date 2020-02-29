//
//  VaccinationsViewController.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-26.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

class VaccinesViewController: UIViewController {
    
    var pet: Pet!
    
    let cell_id = "vaccine_cell"
    
    weak var tableView: UITableView!
    
     var provider: VaccinesDataProvider! = nil
    
    let dogVaccines: [String:[Vaccine]] = ["core": [Vaccine(name: "Canine Distemper", isCore: true),
                                                    Vaccine(name: "Infectious Canine Hepatitis", isCore: true),
                                                    Vaccine(name: "Canine Parvovirus", isCore: true),
                                                    Vaccine(name: "Rabies", isCore: true)],
                                           "non-core": [Vaccine(name: "Bordetellosis", isCore: false),
                                                        Vaccine(name: "Canine Parainfluenza Virus", isCore: false),
                                                        Vaccine(name: "Leptospirosis", isCore: false),
                                                        Vaccine(name: "Borreliosis", isCore: false)]
    ]
    
    var vaccines = [Vaccine]()
    
    var coreVaccines = [Vaccine]()
    var non_coreVaccines = [Vaccine]()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Vaccinations"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.barTintColor = AppColors.primaryColor
        view.backgroundColor = AppColors.primaryColor
        navigationController?.navigationBar.tintColor = UIColor.white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
        setupTableView()
        
        
         self.tableView.dataSource = self
         self.tableView.delegate = self
         self.tableView.register(VaccineTableViewCell.self, forCellReuseIdentifier: cell_id)
        
        self.provider = VaccinesDataProvider()
        self.provider.delegate = self
        
        self.provider.setVaccineData()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.barTintColor = AppColors.primaryColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setupViews() {
        view.addSubview(titleLabel)
        titleLabel.text = "\(pet.name)'s Vaccines"
        
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
                self.view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
                self.view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
               ])
        
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 80
        tableView.layer.cornerRadius = 8
//        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.tableView = tableView
    }

}
