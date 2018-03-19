//
//  FilterListViewController.swift
//  ViperApp
//
//  Created by Romson Preechawit on 19/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import UIKit

protocol FilterListViewControllerProtocol: AnyObject {
    var filters: [Filter] { get set }
}

protocol FilterListViewDelegate {
    func viewDidLoad()
    func onDoneTapped()
    func onSegmentChange(to page: FilterType)
}

class FilterListViewController: UIViewController, FilterListViewControllerProtocol {
    
    var presentator: FilterListViewDelegate?

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var filters: [Filter] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    @IBAction func onSegmentChanged(_ sender: UISegmentedControl) {
        guard let page = FilterType(rawValue: sender.selectedSegmentIndex) else {
            fatalError("Unknown Segment Selected.")
        }
        presentator?.onSegmentChange(to: page)
    }
    
    @IBAction func onDoneTapped(_ sender: Any) {
        presentator?.onDoneTapped()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presentator?.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FilterListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Filter List Cell")
        let filter = filters[indexPath.row]
        cell?.textLabel?.text = filter.name
        if filter.selected {
            cell!.accessoryType = .checkmark
        } else {
            cell!.accessoryType = .none
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        let filter = filters[indexPath.row]
        filter.selected = !filter.selected
        
        if filter.selected {
            cell!.accessoryType = .checkmark
        } else {
            cell!.accessoryType = .none
        }
        
    }
    
}
