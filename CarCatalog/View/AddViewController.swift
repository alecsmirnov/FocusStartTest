//
//  AddViewController.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//

import UIKit

class AddViewController: EditorViewController {
    var addViewModel: AddViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func didTapAdd(_ sender: UIButton) {
        if let addViewModel = addViewModel {
            guard let year = yearTextField.text else { return }
            guard let manufacturer = manufacturerTextField.text else { return }
            guard let model = modelTextField.text else { return }
            guard let type = typeTextField.text else { return }
            
            if year.isEmpty {
                showAlertMessage(title: "Warning", message: "Year cannot be empty!")
                return
            }
            
            if manufacturer.isEmpty {
                showAlertMessage(title: "Warning", message: "Manufacturer cannot be empty!")
                return
            }
            
            if model.isEmpty {
                showAlertMessage(title: "Warning", message: "Model cannot be empty!")
                return
            }
            
            if type.isEmpty {
                showAlertMessage(title: "Warning", message: "Type cannot be empty!")
                return
            }
            
            addViewModel.userAddedCar(year: year, manufacturer: manufacturer, model: model, type: type)
            
            showMessageBox(message: "New car added successfully", durationTime: 1)
            
            yearTextField.text = ""
            manufacturerTextField.text = ""
            modelTextField.text = ""
            typeTextField.text = ""
        }
    }
}
