//
//  CarEntity+CoreDataProperties.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//
//

import Foundation
import CoreData

extension CarEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarEntity> {
        return NSFetchRequest<CarEntity>(entityName: "CarEntity")
    }

    @NSManaged public var year: String
    @NSManaged public var manufacturer: String
    @NSManaged public var model: String
    @NSManaged public var type: String
}
