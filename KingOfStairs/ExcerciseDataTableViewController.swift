//
//  ExcerciseDataTableViewController.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 23..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import UIKit

class ExcerciseDataTableViewController: UITableViewController {
    
    let data = DataController.sharedInstance().excerciseData
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categories = Array(data.values)[section]
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath)
        
        let excerciseTimes = Array(data.values)[indexPath.section]
        let time = excerciseTimes[indexPath.row].time
        let floors = excerciseTimes[indexPath.row].floors
        
        cell.textLabel?.text = String(floors * 7) + " kcl"
        cell.detailTextLabel?.text = time
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(data.keys)[section]
    }
    
    @IBAction func dismissMyreportView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
