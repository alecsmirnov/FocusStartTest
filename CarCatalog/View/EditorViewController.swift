//
//  EditorViewController.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController {    
    @IBOutlet internal var yearTextField: UITextField!
    @IBOutlet internal var manufacturerTextField: UITextField!
    @IBOutlet internal var modelTextField: UITextField!
    @IBOutlet internal var typeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    internal func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
}
