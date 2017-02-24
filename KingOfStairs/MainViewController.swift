//
//  MainViewController.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 24..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import SwiftKeychainWrapper

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func logOut(_ sender: Any) {
        KeychainWrapper.standard.removeAllKeys()
        try! FIRAuth.auth()!.signOut()
        FBSDKLoginManager().logOut()
        performSegue(withIdentifier: "goToLog", sender: nil)
    }


}
