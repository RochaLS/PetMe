//
//  GroupVC+TableViewDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-30.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit

extension GroupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupTableViewCell
        
    
        
        if isOwner == false {
            cell.deleteButton.isHidden = true
            cell.deleteButton.isEnabled = false
        }
        
        cell.nameLabel.text = members[indexPath.row].name
        cell.selectionStyle = .none
        cell.setupView()
        cell.delegate = self
        cell.setupMember(member: members[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    
}
