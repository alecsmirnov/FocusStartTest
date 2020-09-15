//
//  CarsViewModelDisplayDelegate.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//

import Foundation

protocol CarsViewModelDisplayDelegate: AnyObject {
    func carsViewModelDisplayDelegateReloadRow(_ viewController: AnyObject, at index: Int)
    func carsViewModelDisplayDelegateReloadData(_ viewController: AnyObject)
}
