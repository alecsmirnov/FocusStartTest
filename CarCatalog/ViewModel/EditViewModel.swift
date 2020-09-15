//
//  EditViewModel.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//

import Foundation

class EditViewModel: EditorViewModel {
    let year: String
    let manufacturer: String
    let model: String
    let type: String
    
    private let row: Int
    
    init(car: Car, row: Int) {
        self.year = car.year
        self.manufacturer = car.manufacturer
        self.model = car.model
        self.type = car.type
        
        self.row = row
    }
    
    convenience init(car: Car, row: Int, delegate: EditorViewModelDelegate) {
        self.init(car: car, row: row)
        
        self.delegate = delegate
    }
    
    override func userChangedCar(year: String, manufacturer: String, model: String, type: String) {
        if let delegate = delegate {
            let car = Car(year: year, manufacturer: manufacturer, model: model, type: type)
            
            delegate.editorViewModelDelegateEditCar(self, car: car, at: row)
        }
    }
    
    override func userDeletedCar() {
        if let delegate = delegate {
            delegate.editorViewModelDelegateDeleteCar(self, at: row)
        }
    }
}
