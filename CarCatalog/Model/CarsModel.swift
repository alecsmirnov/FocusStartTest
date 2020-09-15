//
//  CarsModel.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//

import Foundation

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
    
    private var data = [Car]()
    
    func append(car: Car) {
        data.append(car)
    }
    
    func get(at index: Int) -> Car {
        guard data.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        return data[index]
    }
    
    func remove(at index: Int) {
        guard data.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        data.remove(at: index)
    }
    
    func replace(at index: Int, with car: Car) {
        guard data.indices.contains(index) else {
            fatalError("index is out of range")
        }
        
        data[index] = car
    }
    
    deinit {
        data.removeAll()
    }
}
