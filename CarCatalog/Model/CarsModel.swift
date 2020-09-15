//
//  CarsModel.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//

import UIKit
import CoreData

struct Car {
    let year: String
    let manufacturer: String
    let model: String
    let type: String
}

class CarsModel {
    var isEmpty: Bool {
        return data.isEmpty
    }
    
    var count: Int {
        return data.count
    }
    
    private var data: [CarEntity] = []
    private var managedContext: NSManagedObjectContext!
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<CarEntity> = CarEntity.fetchRequest()

        do {
            data = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            fatalError("could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func append(car: Car) {
        if let managedContext = managedContext {
            guard let carEntityDescription = NSEntityDescription.entity(forEntityName: EntityNames.car, in: managedContext) else {
                fatalError("incorrect entity name: \(EntityNames.car)")
            }
            
            let carEntity = CarEntity(entity: carEntityDescription, insertInto: managedContext)
            
            carEntity.year = car.year
            carEntity.manufacturer = car.manufacturer
            carEntity.model = car.model
            carEntity.type = car.type
            
            do {
                data.append(carEntity)
                
                try managedContext.save()
            } catch let error as NSError {
                fatalError("could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func get(at index: Int) -> Car {
        guard data.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        return Car(year: data[index].year,
                   manufacturer: data[index].manufacturer,
                   model: data[index].model,
                   type: data[index].type)
    }
    
    func remove(at index: Int) {
        guard data.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        data.remove(at: index)
        
        if let managedContext = managedContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.car)

            do {
                let entities = try managedContext.fetch(fetchRequest) as! [CarEntity]
                let entityObject = entities[index] as NSManagedObject
                    
                managedContext.delete(entityObject)
                    
                try managedContext.save()
            } catch let error as NSError {
                fatalError("could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func replace(at index: Int, with car: Car) {
        guard data.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        if let managedContext = managedContext {
            do {
                data[index].year = car.year
                data[index].manufacturer = car.manufacturer
                data[index].model = car.model
                data[index].type = car.type
                    
                try managedContext.save()
            } catch let error as NSError {
                fatalError("could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func removeAll() {
        data.removeAll()
        
        if let managedContext = managedContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.car)

            do {
                let entities = try managedContext.fetch(fetchRequest)

                for entity in entities {
                    let entityObject = entity as! NSManagedObject

                    managedContext.delete(entityObject)
                }
            } catch let error as NSError {
                fatalError("could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    deinit {
        removeAll()
    }
}
