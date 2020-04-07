//
//  InvitesVC+GroupDataProviderDelegate.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-04-06.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

extension InvitesViewController: GroupDataProviderDelegate {
    func didGetRequests(allRequests: [Request]) {
        requests = allRequests
        tableView.reloadData()
    }
}
