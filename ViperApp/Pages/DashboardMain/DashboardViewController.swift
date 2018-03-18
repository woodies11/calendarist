//
//  DashboardViewController.swift
//  ViperApp
//
//  Created by Romson Preechawit on 18/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import UIKit

struct DashboardTask {
    var content: String!
    var due: NSDate!
}

class DashboardViewController: UIViewController {

    var presentator: DashboardPresentatorProtocol?
    
    // Class variables
    var taskList: [DashboardTask] = []

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

extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeueCell = tableView.dequeueReusableCell(withIdentifier: "Dashboard Task Cell")
        guard let cell = dequeueCell else {
            // TODO: create a new cell and set instead
            return UITableViewCell()
        }
        cell.textLabel?.text = "Test \(indexPath.row)"
        return cell
    }
    
}

extension DashboardViewController: UITableViewDelegate {
    
}
