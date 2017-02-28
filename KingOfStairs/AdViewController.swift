//
//  AdViewController.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 23..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class AdViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var monthlyKcl: UIButton!
    @IBOutlet weak var todayKcl: UILabel!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var userSmallImage: UIImageView!
    
    var AdPageViewController: AdPageViewController? {
        didSet {
            AdPageViewController?.AdDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.addTarget(self, action: #selector(AdViewController.didChangePageControlValue), for: .valueChanged)
        let dataControllerAccess = DataController.sharedInstance()
        
        monthlyKcl.setTitle("\(dataControllerAccess.monthlySum()) 층", for: .normal)
        todayDate.text = DataController.sharedInstance().getTodayDate()
        
        userSmallImage.layer.cornerRadius = userSmallImage.frame.size.width / 2
        userSmallImage.clipsToBounds = true
        userSmallImage.contentMode = .scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todayKcl.text = String(DataController.sharedInstance().kclCalculator()) + " kcl"
        
        monthlyKcl.setTitle("\(Double(DataController.sharedInstance().monthlySum())! * 7)" + " kcl", for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let AdPageViewController = segue.destination as? AdPageViewController {
            self.AdPageViewController = AdPageViewController
        }
        
    }
    @IBAction func logOut(_ sender: Any) {
        KeychainWrapper.standard.removeAllKeys()
        try! FIRAuth.auth()?.signOut()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LogViewController") as! LogViewController
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        AdPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension AdViewController: AdPageViewControllerDelegate {
    
    func AdPageViewController(_ AdPageViewController: AdPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func AdPageViewController(_ AdPageViewController: AdPageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}
