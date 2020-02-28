//
//  VaccinationsTBDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-26.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

extension VaccinationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if let vaccines = dogVaccines["core"] {
                return vaccines.count
            }
        }
        
        if section == 1 {
            if let vaccines = dogVaccines["non-core"] {
                return vaccines.count
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_id, for: indexPath) as! VaccineTableViewCell
        if indexPath.section == 0 {
            if let vaccines = dogVaccines["core"] {
                cell.vaccineName.text = vaccines[indexPath.row].name
                if vaccines[indexPath.row].date == nil {
                    cell.status.isHidden = true
                } else {
                    cell.status.text = dateToString(date: vaccines[indexPath.row].date!)
                }
            }
        } else {
            if let vaccines = dogVaccines["non-core"] {
                cell.vaccineName.text = vaccines[indexPath.row].name
                if vaccines[indexPath.row].date == nil {
                    cell.status.isHidden = true
                } else {
                    cell.status.text = dateToString(date: vaccines[indexPath.row].date!)
                }
            }
        }
        
        
        cell.setupView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Core Vaccines"
        } else {
            return "Non-Core Vaccines"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = AppColors.black
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: date)
    }
    
    
}
