//
//  EditorViewModel.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//

import Foundation

class EditorViewModel {
    internal weak var delegate: EditorViewModelDelegate?
    
    func userAddedCar(year: String, manufacturer: String, model: String, type: String) {
        fatalError("this method must be overridden")
    }
    
    func userChangedCar(year: String, manufacturer: String, model: String, type: String) {
        fatalError("this method must be overridden")
    }
    
    func userDeletedCar() {
        fatalError("this method must be overridden")
    }
}
