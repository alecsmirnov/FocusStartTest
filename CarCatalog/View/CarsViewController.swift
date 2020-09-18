//
//  CarsViewController.swift
//  CarCatalog
//
//  Created by Admin on 15.09.2020.
//  Copyright © 2020 Alec. All rights reserved.
//

import UIKit

// Rules for updating carsTableView content when its changes
private enum ScheduleReloadType: Equatable {
    case none
    case all
    case row(index: Int)
}

class CarsViewController: UIViewController {
    var carsViewModel: CarsViewModel?
    
    private var reloadType = ScheduleReloadType.none
    
    @IBOutlet private var carsTableView: UITableView!
    @IBOutlet private var emptyTableViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carsTableView.dataSource = self
        carsTableView.delegate = self
        
        carsTableView.tableFooterView = UIView()
        
        if let carsViewModel = carsViewModel {
            carsViewModel.delegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
    
    @IBAction func didTapAdd(_ sender: UIBarButtonItem) {
        if let storyboard = storyboard {
            let addViewController = storyboard.instantiateViewController(withIdentifier: StoryboardIds.addViewController) as! AddViewController
            
            if let carsViewModel = carsViewModel {
                addViewController.addViewModel = carsViewModel.addViewModel()
            }
            
            if let navigationController = navigationController {
                navigationController.pushViewController(addViewController, animated: true)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension CarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsCount = 0

        if let carsViewModel = carsViewModel {
            rowsCount = carsViewModel.rowsCount
        }
        
        emptyTableViewLabel.isHidden = rowsCount == 0 ? false : true

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

// MARK: - UITableViewDelegate

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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] (_, _, completionHandler) in
            if let carsViewModel = self.carsViewModel {
                carsViewModel.userDeletedRow(at: indexPath.row)
                self.carsTableView.reloadData()
                
                completionHandler(true)
            }
        }
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { [unowned self] (_, _, completionHandler) in
            self.tableView(tableView, didSelectRowAt: indexPath)
            
            completionHandler(true)
        }
        
        delete.image = UIImage.init(systemName: "trash")
        edit.image = UIImage.init(systemName: "pencil")
        
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
}

// MARK: - CarsViewModelDisplayDelegate

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
