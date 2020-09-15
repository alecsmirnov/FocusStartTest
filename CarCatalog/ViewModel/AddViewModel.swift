//
//  AddViewModel.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//

import Foundation

class AddViewModel: EditorViewModel {
    convenience init(delegate: EditorViewModelDelegate) {
        self.init()
        
        self.delegate = delegate
    }
    
    override func userAddedCar(year: String, manufacturer: String, model: String, type: String) {
        if let delegate = delegate {
            let car = Car(year: year, manufacturer: manufacturer, model: model, type: type)
            
            delegate.editorViewModelDelegateAddCar(self, car: car)
        }
    }
}
