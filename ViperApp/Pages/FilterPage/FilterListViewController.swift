//
//  FilterListViewController.swift
//  ViperApp
//
//  Created by Romson Preechawit on 19/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import UIKit

protocol FilterListViewControllerProtocol: AnyObject {
    
}

class FilterListViewController: UIViewController, FilterListViewControllerProtocol {
    
    var presentator: FilterListPresentatorDelegate?

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var filterList: [String: [Filter]] = [:] {
        didSet {
            self.reloadView()
        }
    }
    
    @IBAction func onDoneTapped(_ sender: Any) {
        presentator?.onDoneTapped(returning: filterList)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.reloadView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadView() {
        // Prevent trying to access the view before view loaded
        // When we first set filterList for the first time, the view
        // may not yet shown to the user so these UI elements are
        // still nil
        if let segmentControl = segmentControl {
            segmentControl.removeAllSegments()
            var count = 0
            for filterType in filterList {
                segmentControl.insertSegment(withTitle: filterType.key, at: count, animated: false)
                count += 1
            }
        }
    }

}

extension FilterListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
