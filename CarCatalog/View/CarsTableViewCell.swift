//
//  CarsTableViewCell.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//

import UIKit

class CarsTableViewCell: UITableViewCell {
    var carsTableViewModelCell: CarsTableViewModelCell? {
        didSet {
            if let carsTableViewModelCell = carsTableViewModelCell {
                yearLabel.text = carsTableViewModelCell.year
                manufacturerLabel.text = carsTableViewModelCell.manufacturer
                modelLabel.text = carsTableViewModelCell.model
                typeLabel.text = carsTableViewModelCell.type
            }
        }
    }
    
    @IBOutlet private var yearLabel: UILabel!
    @IBOutlet private var manufacturerLabel: UILabel!
    @IBOutlet private var modelLabel: UILabel!
    @IBOutlet private var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
