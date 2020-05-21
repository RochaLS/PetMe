//
//  VaccineInfo+TableViewDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-02.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

extension VaccineInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numOfRows = section == 0 ? 2 : 1
        return numOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cell_id, for: indexPath) as! VaccineInfoTableViewCell
            
            cell.setupView()
            
            if indexPath.row != 0 || indexPath.section == 1 {
                cell.switchButton.isHidden = true
            }
            cell.switchButton.addTarget(self, action: #selector(switchButtonValueChanged), for: .valueChanged)
            
            switch indexPath.row {
            case 0:
                cell.mainLabel.text = "Vaccine Received"
                if vaccine.taken == true {
                    cell.switchButton.isOn = true
                } else if vaccine.taken == false {
                    cell.switchButton.isOn = false
                }
            case 1:
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yy"
                if dateSelected == nil && vaccine.date == nil {
                    cell.mainLabel.text = "Date"
                } else if vaccine.date == nil {
                    cell.mainLabel.text = dateFormatter.string(from: dateSelected!)
                } else {
                    cell.mainLabel.text = dateFormatter.string(from: vaccine.date!)
                }
                cell.mainLabel.textColor = UIColor.lightGray
            default:
                cell.mainLabel.text = "Vaccine"
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: about_id, for: indexPath) as! AboutTableViewCell
            cell.setupView()
            cell.mainLabel.numberOfLines = 0
            if aboutDataOfDogs["\(vaccine.name)"] == nil {
                cell.mainLabel.text = aboutDataOfCats["\(vaccine.name)"]
            } else {
                cell.mainLabel.text = aboutDataOfDogs["\(vaccine.name)"]
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = indexPath.section == 0 ? 80 : UITableView.automaticDimension //calculates height of label contents/text
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "About"
        }
        
        return ""
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = AppColors.black
        header.textLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        header.backgroundColor = .red
        header.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}
