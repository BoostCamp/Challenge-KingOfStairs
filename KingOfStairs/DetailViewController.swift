//
//  DetailViewController.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 23..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userKcl: UILabel!
    @IBOutlet weak var comments: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func backToHallOfFameView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
