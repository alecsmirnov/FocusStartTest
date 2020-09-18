//
//  CarsViewModel.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//

import Foundation

class CarsViewModel {
    weak var delegate: CarsViewModelDisplayDelegate?
    
    var rowsCount: Int {
        return carsModel.count
    }
    
    private let carsModel: CarsModel
    
    init(carsModel: CarsModel) {
        self.carsModel = carsModel
    }
    
    func addViewModel() -> AddViewModel {
        return AddViewModel(delegate: self)
    }
    
    func editViewModel(at index: Int) -> EditViewModel {
        return EditViewModel(car: carsModel.get(at: index), row: index, delegate: self)
    }
    
    func carsTableViewModelCell(at index: Int) -> CarsTableViewModelCell {
        return CarsTableViewModelCell(car: carsModel.get(at: index))
    }
    
    func userDeletedRow(at index: Int) {
        carsModel.remove(at: index)
    }
}

// MARK: - EditorViewModelDelegate

extension CarsViewModel: EditorViewModelDelegate {
    func editorViewModelDelegateAddCar(_ viewModel: AnyObject, car: Car) {
        carsModel.append(car: car)
        
        if let delegate = delegate {
            delegate.carsViewModelDisplayDelegateReloadData(self)
        }
    }
    
    func editorViewModelDelegateEditCar(_ viewModel: AnyObject, car: Car, at index: Int) {
        carsModel.replace(at: index, with: car)
        
        if let delegate = delegate {
            delegate.carsViewModelDisplayDelegateReloadRow(self, at: index)
        }
    }
    
    func editorViewModelDelegateDeleteCar(_ viewModel: AnyObject, at index: Int) {
        carsModel.remove(at: index)
        
        if let delegate = delegate {
            delegate.carsViewModelDisplayDelegateReloadData(self)
        }
    }
}
