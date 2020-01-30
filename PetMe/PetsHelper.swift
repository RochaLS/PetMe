//
//  PetsHelper.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-01-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import UIKit
import CoreData


extension AllPetsController {
    
    func clearData() {
        
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        
        if let context = delegate?.persistentContainer.viewContext {
            
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pet")
                
                
                let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
                
                for object in objects! {
                    context.delete(object)
                }
            } catch let error {
                print(error)
            }
            
            
            
            
        }
    }
    
    
    func setupData() {
        
        clearData()
        
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let drika = NSEntityDescription.insertNewObject(forEntityName: "Pet", into: context) as! Pet
            drika.name = "Drika"
            drika.imgName = "drika"
            drika.created_at = Date()
            
            let preto = NSEntityDescription.insertNewObject(forEntityName: "Pet", into: context) as! Pet
            preto.name = "Preto"
            preto.imgName = "preto"
            preto.created_at = Date()
            
            
            do {
                try context.save()
            } catch let error {
                print(error)
            }
            
        }
        
        loadData()
    }
    
    func loadData() {
        
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pet")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: true)]
            
            do {
                pets = try context.fetch(fetchRequest) as? [Pet]
            } catch let error {
                print(error)
            }
        }
        
        
    }
}
