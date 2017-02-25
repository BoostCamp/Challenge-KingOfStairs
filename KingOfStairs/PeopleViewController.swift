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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        todayDate.text = DataController.sharedInstance().today
        
        totlaKcl.setTitle("\(Double(DataController.sharedInstance().monthlySum())! * 7)" + " kcl", for: .normal)

        KingProfile.layer.cornerRadius = KingProfile.frame.size.width / 2
        KingProfile.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let data = DataController.sharedInstance().userData
        let selectedPlace = DataController.sharedInstance().selectedPlace
        
        todayKcl.text = DataController.sharedInstance().kclCalculator() + " kcl"
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "myCell") as! FeedTableViewCell

    }
    
    
}

