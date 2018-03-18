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
    var taskList: [Date: [String]] { get set }
    func showAlert(title: String, message: String)
}

class DashboardViewController: UIViewController, DashboardViewControllerProtocol {

    var presentator: DashboardPresentatorDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    
    // Class variables
    var taskList: [Date: [String]] = [:] {
        didSet {
            tableView.reloadData()
            calendar.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presentator?.viewDidLoad()
        
        // Select the current date by default
        calendar.select(Date())
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
        var selectedDate = Date().startOfDay
        if calendar.selectedDate != nil {
            selectedDate = calendar.selectedDate!
        }
        
        guard let dateTaskList = taskList[selectedDate] else {
            return 0
        }
        
        return dateTaskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeueCell = tableView.dequeueReusableCell(withIdentifier: "Dashboard Task Cell")
        guard let cell = dequeueCell else {
            // TODO: create a new cell and set instead
            return UITableViewCell()
        }
        
        var selectedDate = Date().startOfDay
        if calendar.selectedDate != nil {
            selectedDate = calendar.selectedDate!
        }
        
        guard let dateTaskList = taskList[selectedDate] else {
            fatalError("Attempting to display empty date. TableView numberOfRowsInSection should return 0 so this func should not run.")
        }
        
        cell.textLabel?.text = dateTaskList[indexPath.row]
        return cell
    }
    
}

extension DashboardViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        tableView.reloadData()
    }
}

extension DashboardViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        if let tasks = taskList[date.startOfDay] {
            return UIColor(red: 1, green: min(1-0.2*CGFloat(tasks.count), 1), blue: 0, alpha: 1)
        }
        return UIColor.white
    }
    
}
