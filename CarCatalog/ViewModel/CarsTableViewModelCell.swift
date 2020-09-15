//
//  CarsTableViewModelCell.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//

import Foundation

struct CarsTableViewModelCell {
    let year: String
    let manufacturer: String
    let model: String
    let type: String
    
    init(car: Car) {
        self.year = car.year
        self.manufacturer = car.manufacturer
        self.model = car.model
        self.type = car.type
    }
}
