//
//  FilterListViewController.swift
//  ViperApp
//
//  Created by Romson Preechawit on 19/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import UIKit

protocol FilterListViewControllerProtocol: AnyObject {
    var filterList: [String: NSMutableArray]! { get set }
}

class FilterListViewController: UIViewController, FilterListViewControllerProtocol {
    
    var presentator: FilterListPresentatorDelegate?

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var filterList: [String: NSMutableArray]! = [:] {
        didSet {
            self.reloadView()
        }
    }
    
    var segmentKey: [Int: String] = [:]
    
    @IBAction func onSegmentChanged(_ sender: Any) {
        tableView.reloadData()
    }
    
    @IBAction func onDoneTapped(_ sender: Any) {
//        presentator?.onDoneTapped(returning: filterList)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presentator?.viewDidLoad()
        self.reloadView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadView() {
        // "if let" prevent trying to access the view before view loaded
        // When we first set filterList for the first time, the view
        // may not yet shown to the user so these UI elements are
        // still nil
        if let segmentControl = segmentControl {
            segmentControl.removeAllSegments()
            var count = 0
            for filterType in filterList {
                segmentKey[count] = filterType.key
                segmentControl.insertSegment(withTitle: filterType.key, at: count, animated: false)
                count += 1
            }
            segmentControl.selectedSegmentIndex = 0
        }
        tableView.reloadData()
    }

}

extension FilterListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let key = segmentKey[segmentControl.selectedSegmentIndex] else {
            return 0
        }
        
        guard let filters = filterList[key] else {
            return 0
        }
        
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filters = filterList[segmentKey[segmentControl.selectedSegmentIndex]!]!
        var cell = tableView.dequeueReusableCell(withIdentifier: "Filter List Cell")
        if cell == nil {
            cell = UITableViewCell()
        }
        
        let filter = filters[indexPath.row] as! Filter
        
        cell!.textLabel?.text = filter.name
        if filter.selected {
            cell!.accessoryType = .checkmark
        } else {
            cell!.accessoryType = .none
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var filter = filterList[segmentKey[segmentControl.selectedSegmentIndex]!]![indexPath.row] as! Filter
        filter.selected = !filter.selected
        
        let cell = tableView.cellForRow(at: indexPath)
        if filter.selected {
            cell!.accessoryType = .checkmark
        } else {
            cell!.accessoryType = .none
        }
    }
}
