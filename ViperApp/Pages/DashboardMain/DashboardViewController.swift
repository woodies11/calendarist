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
    
    // We could have the Presentator ask for a list of task only
    // for a specific date from the Interactor but since we need
    // all the task present in that month to display the whole
    // calendar anyway, let's just have the tableview decide
    // what to display by itself.
    var taskList: [Date: [String]] = [:] {
        didSet {
            tableView.reloadData()
            calendar.reloadData()
        }
    }

    @IBAction func onFilterButtonTapped(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate this to presentator.
        presentator?.viewDidLoad()
        
        // Select the current date by default
        // This is a UI function so it is fine in the view
        calendar.select(Date())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Display a simple alert with a "Dismiss" button.
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Get the selected date from calendar.
        // If no date is selected, use the current date.
        var selectedDate = Date().startOfDay
        if calendar.selectedDate != nil {
            selectedDate = calendar.selectedDate!
        }
        
        // If the selected date does not have any tasks,
        // the entry will not exist in our dictionary.
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
        
        // Get the selected date from calendar.
        // If no date is selected, use the current date.
        var selectedDate = Date().startOfDay
        if calendar.selectedDate != nil {
            selectedDate = calendar.selectedDate!
        }
        
        // If the selected date has no task (does not exist in the dictionary)
        // then "numberOfRowsInSection" should return 0 and this function
        // should not be called at all.
        guard let dateTaskList = taskList[selectedDate] else {
            fatalError("Attempting to display empty date. TableView numberOfRowsInSection should return 0 so this func should not run.")
        }
        
        // Set cell label to display the task name
        cell.textLabel?.text = dateTaskList[indexPath.row]
        return cell
    }
    
}

extension DashboardViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // If a date is selected, tell tableView to
        // update the task list to display tasks for
        // that date.
        tableView.reloadData()
    }
}

extension DashboardViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        
        // We want to display a heat map on our calendar
        // based on the number of task due on each date.
        
        if let tasks = taskList[date.startOfDay] {
            // If there are tasks due on this date,
            // calculate the background color based
            // on the number of tasks due. The more
            // tasks there is, the closer the color
            // is to pure red.
            return UIColor(red: 1, green: min(1-0.2*CGFloat(tasks.count), 1), blue: 0, alpha: 1)
        }
        return UIColor.white
    }
    
}
