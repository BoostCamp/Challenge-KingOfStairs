//
//  PeopleViewController.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 21..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SwiftKeychainWrapper

class PeopleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var KingProfile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userComment: UILabel!
    @IBOutlet weak var todayKcl: UILabel!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var totlaKcl: UIButton!
    @IBOutlet weak var feedNumber: UILabel!
    @IBOutlet weak var textfield: UITextField!
    
    var userData = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        todayDate.text = DataController.sharedInstance().getTodayDate()
        
        totlaKcl.setTitle("\(Double(DataController.sharedInstance().monthlySum())! * 7)" + " kcl", for: .normal)

        KingProfile.layer.cornerRadius = KingProfile.frame.size.width / 2
        KingProfile.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let data = DataController.sharedInstance().userData
        let selectedPlace = DataController.sharedInstance().selectedPlace
        let udata = DataController.sharedInstance().userData
        userData = DataController.sharedInstance().filterByBuilding(data: udata, selectedPlace: DataController.sharedInstance().selectedPlace)
        tableView.reloadData()
        
        todayKcl.text = String(DataController.sharedInstance().kclCalculator()) + " kcl"
        KingProfile.image = DataController.sharedInstance().filterByBuilding(data: data, selectedPlace: selectedPlace)[0].userImage
        userName.text = DataController.sharedInstance().filterByBuilding(data: data, selectedPlace: selectedPlace)[0].name
        userComment.text = DataController.sharedInstance().filterByBuilding(data: data, selectedPlace: selectedPlace)[0].userComment
    }


    
    @IBAction func logOut(_ sender: Any) {
        KeychainWrapper.standard.removeAllKeys()
        try! FIRAuth.auth()?.signOut()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LogViewController") as! LogViewController
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! FeedTableViewCell
        
        cell.profileImg.layer.cornerRadius = cell.profileImg.frame.size.width / 2
        cell.profileImg.clipsToBounds = true
        cell.profileImg.image = userData[indexPath.row].userImage
        cell.caption.text = userData[indexPath.row].userComment
        cell.username.text = userData[indexPath.row].name
        cell.feedNumber.text = String(Int(arc4random_uniform(6) + 1))
        
        return cell

    }
    
    
}

