//
//  VaccinesDataProviderDelegateMethods.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-02-28.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation

extension VaccinesViewController: VaccinesDataProviderDelegate {
    func didGetVaccinesData(allVaccines: [Vaccine]) {
        coreVaccines.removeAll()
        non_coreVaccines.removeAll()
        for vaccine in allVaccines {
            if vaccine.isCore == true {
                coreVaccines.append(vaccine)
            } else if vaccine.isCore == false {
                non_coreVaccines.append(vaccine)
            }
        }
        self.tableView.reloadData()
    }
}
