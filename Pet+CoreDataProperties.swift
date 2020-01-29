//
//  Pet+CoreDataProperties.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-01-29.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//
//

import Foundation
import CoreData


extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet")
    }

    @NSManaged public var imgName: String?
    @NSManaged public var name: String?
    @NSManaged public var created_at: Date?

}
