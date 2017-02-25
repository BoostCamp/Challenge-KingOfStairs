//
//  RankingTableViewController.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 23..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import UIKit

class RankingTableViewController: UITableViewController {
    
    var userData = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let udata = DataController.sharedInstance().userData
        userData = DataController.sharedInstance().filterByBuilding(data: udata, selectedPlace: DataController.sharedInstance().selectedPlace)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! RankingTableViewCell
        
        cell.userImage.layer.cornerRadius = cell.userImage.frame.size.width / 2
        cell.userImage.clipsToBounds = true
        
        cell.userName.text = userData[indexPath.row].name
        if let userValue = userData[indexPath.row].kclPoint {
            cell.totalKcl.text = String(userValue) + "Kcl"
        }
        
        cell.userImage.image = userData[indexPath.row].userImage
        if indexPath.row <= 2 {
            cell.userRanking.image = UIImage(named: "\(indexPath.row)")
        } else {
            cell.userRanking.image = UIImage(named: "Star")
        }
        cell.comment.text = userData[indexPath.row].userComment
        
        return cell
    }
    
}
