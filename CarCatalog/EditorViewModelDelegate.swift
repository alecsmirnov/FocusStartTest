//
//  EditorViewModelDelegate.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//

import Foundation

protocol EditorViewModelDelegate: AnyObject {
    func editorViewModelDelegateAddCar(_ viewModel: AnyObject, car: Car)
    func editorViewModelDelegateEditCar(_ viewModel: AnyObject, car: Car, at index: Int)
    func editorViewModelDelegateDeleteCar(_ viewModel: AnyObject, at index: Int)
}
