//
//  VaccinationsTBDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-26.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

extension VaccinesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return coreVaccines.count
        }
        
        
        if section == 1 {
            return non_coreVaccines.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_id, for: indexPath) as! VaccineTableViewCell
        if indexPath.section == 0 {
            
            cell.vaccineName.text = coreVaccines[indexPath.row].name
            if coreVaccines[indexPath.row].date == nil {
                cell.status.isHidden = true
            } else {
                cell.status.text = dateToString(date: coreVaccines[indexPath.row].date!)
            }
            
            checkIfVaccineIsTaken(cell: cell, vaccine: coreVaccines[indexPath.row])
            
        } else {
            
            cell.vaccineName.text = non_coreVaccines[indexPath.row].name
            if non_coreVaccines[indexPath.row].date == nil {
                cell.status.isHidden = true
            } else {
                cell.status.text = dateToString(date: non_coreVaccines[indexPath.row].date!)
            }
            
            checkIfVaccineIsTaken(cell: cell, vaccine: non_coreVaccines[indexPath.row])
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = VaccineInfoViewController()
        controller.vaccine = indexPath.section == 0 ? coreVaccines[indexPath.row] :  non_coreVaccines[indexPath.row]
        controller.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func checkIfVaccineIsTaken(cell: VaccineTableViewCell, vaccine: Vaccine) {
        if vaccine.taken == true  {
            cell.isDone.textColor = AppColors.primaryColor
        }
    }
}
