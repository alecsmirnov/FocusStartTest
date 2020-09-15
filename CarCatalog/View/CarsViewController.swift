//
//  CarsViewController.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//

import UIKit

private enum ScheduleReloadType: Equatable {
    case none
    case all
    case row(index: Int)
}

class CarsViewController: UIViewController {
    var carsViewModel: CarsViewModel?
    
    private var reloadType = ScheduleReloadType.none
    
    @IBOutlet private var carsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carsTableView.dataSource = self
        carsTableView.delegate = self
        
        if let carsViewModel = carsViewModel {
            carsViewModel.delegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        switch reloadType {
        case ScheduleReloadType.all:
            carsTableView.reloadData()
            break
        case ScheduleReloadType.row(let index):
            carsTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            break
        default:
            break
        }
        
        reloadType = ScheduleReloadType.none
    }
}

extension CarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsCount = 0
        
        if let carsViewModel = carsViewModel {
            rowsCount = carsViewModel.rowsCount
        }

        return rowsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let carsTableViewCell = carsTableView.dequeueReusableCell(withIdentifier: StoryboardIds.carsTableViewCell) as! CarsTableViewCell
        
        if let carsViewModel = carsViewModel {
            carsTableViewCell.carsTableViewModelCell = carsViewModel.carsTableViewModelCell(at: indexPath.row)
        }
        
        return carsTableViewCell
    }
}

extension CarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let storyboard = storyboard {
            let editViewController = storyboard.instantiateViewController(withIdentifier: StoryboardIds.editViewController) as! EditViewController
            
            if let carsViewModel = carsViewModel {
                editViewController.editViewModel = carsViewModel.editViewModel(at: indexPath.row)
            }
            
            if let navigationController = navigationController {
                navigationController.pushViewController(editViewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let carsViewModel = carsViewModel {
                carsViewModel.userDeletedRow(at: indexPath.row)
            }
        }
    }
}

extension CarsViewController: CarsViewModelDisplayDelegate {
    func carsViewModelDisplayDelegateReloadRow(_ viewController: AnyObject, at index: Int) {
        if reloadType == ScheduleReloadType.none {
            reloadType = ScheduleReloadType.row(index: index)
        }
    }
    
    func carsViewModelDisplayDelegateReloadData(_ viewController: AnyObject) {
        reloadType = ScheduleReloadType.all
    }
}
