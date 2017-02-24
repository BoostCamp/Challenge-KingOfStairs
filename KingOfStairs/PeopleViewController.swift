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

class PeopleViewController: UIViewController {
    
    @IBOutlet weak var KingProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KingProfile.layer.cornerRadius = KingProfile.frame.size.width / 2
        KingProfile.clipsToBounds = true
        
        let data = DataController.sharedInstance().userData
        let selectedPlace = DataController.sharedInstance().selectedPlace
        KingProfile.image = DataController.sharedInstance().filterByBuilding(data: data, selectedPlace: selectedPlace)[0].userImage
        
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        KeychainWrapper.standard.removeAllKeys()
        try! FIRAuth.auth()?.signOut()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LogViewController") as! LogViewController
        self.present(nextViewController, animated: true, completion: nil)
    }
}
