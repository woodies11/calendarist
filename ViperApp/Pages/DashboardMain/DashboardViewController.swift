//
//  DashboardViewController.swift
//  ViperApp
//
//  Created by Romson Preechawit on 18/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import UIKit
import FSCalendar

protocol DashboardViewControllerProtocol: AnyObject {
    var taskList: [String] { get set }
    func showAlert(title: String, message: String)
}

class DashboardViewController: UIViewController, DashboardViewControllerProtocol {

    var presentator: DashboardPresentatorDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    // Class variables
    var taskList: [String] = [] {
        didSet {
            tableView.reloadData()
        }
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
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeueCell = tableView.dequeueReusableCell(withIdentifier: "Dashboard Task Cell")
        guard let cell = dequeueCell else {
            // TODO: create a new cell and set instead
            return UITableViewCell()
        }
        cell.textLabel?.text = taskList[indexPath.row]
        return cell
    }
    
}

extension DashboardViewController: FSCalendarDataSource, FSCalendarDelegate {
    
}
