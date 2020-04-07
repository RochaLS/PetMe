//
//  SettingsVC+TableViewDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-03-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import UIKit
import FontAwesome_swift

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.attributedText = AttrStringHelper.createStringWithIcon(word: "My Group", fontAwesomeIconToAppend: String.fontAwesomeIcon(name: .users), fontSize: 20)
        } else if indexPath.row == 1 {
            cell.textLabel?.attributedText = AttrStringHelper.createStringWithIcon(word: "Invitations", fontAwesomeIconToAppend: String.fontAwesomeIcon(name: .envelope), fontSize: 20)
        } else if indexPath.row == 2 {
            cell.textLabel?.attributedText =  AttrStringHelper.createStringWithIcon(word: "Sign Out", fontAwesomeIconToAppend: String.fontAwesomeIcon(name: .signOutAlt), fontSize: 20)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            goToGroup()
        } else if indexPath.row == 1 {
            goToInvites()
        } else if indexPath.row == 2 {
            signOutUser()
        }
    }
    
    
}
