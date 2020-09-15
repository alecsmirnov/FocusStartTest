//
//  EditViewController.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//

import UIKit

class EditViewController: EditorViewController {
    var editViewModel: EditViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTextFields()
    }
    
    private func initTextFields() {
        if let editViewModel = editViewModel {
            yearTextField.text = editViewModel.year
            manufacturerTextField.text = editViewModel.manufacturer
            modelTextField.text = editViewModel.model
            typeTextField.text = editViewModel.type
        }
    }
    
    private func popViewController() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true);
        }
    }
    
    @IBAction private func didTapEdit(_ sender: UIButton) {
        if let editViewModel = editViewModel {
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
            
            editViewModel.userChangedCar(year: year, manufacturer: manufacturer, model: model, type: type)
        }
    }
    
    @IBAction private func didTapDelete(_ sender: UIButton) {
        if let editViewModel = editViewModel {
            editViewModel.userDeletedCar()
            
            popViewController()
        }
    }
}
