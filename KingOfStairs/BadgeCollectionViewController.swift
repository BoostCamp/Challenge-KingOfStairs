//
//  BadgeCollectionViewController.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 22..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

private let reuseIdentifier = "BadgeIcon"

class BadgeCollectionViewController: UICollectionViewController, UIViewControllerPreviewingDelegate {
    @IBOutlet weak var monthlyKcl: UIButton!
    @IBOutlet weak var todayKcl: UILabel!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var userSmallImage: UIImageView!

    let badgeStore = DataController.sharedInstance().badgeStore
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
        let dataControllerAccess = DataController.sharedInstance()

        todayDate.text = dataControllerAccess.today
        
        todayKcl.text = DataController.sharedInstance().kclCalculator() + " kcl"
        
        monthlyKcl.setTitle("\(Double(DataController.sharedInstance().monthlySum())! * 7)" + " kcl", for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToBadgeDetail" {
            let badge = badgeStore[(collectionView?.indexPathsForSelectedItems?[0].row)!]
            
            let vc = segue.destination as! BadgeDetailViewController
            vc.badge = badge
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badgeStore.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BadgeCollectionViewCell
        
        let badge = badgeStore[indexPath.row]
        
        if let badgeImage = UIImage(named: badge.name) {
            cell.badgeImage.image = badgeImage
        }
        
        return cell
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = collectionView?.indexPathForItem(at: location) else { return nil }
        
        guard let cell = collectionView?.cellForItem(at: indexPath) else { return nil }
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "BadgeDetailViewController") as? BadgeDetailViewController else {
            return nil
        }
        
        let badge = badgeStore[indexPath.row]
        
        detailVC.badge = badge
        
        detailVC.preferredContentSize = CGSize(width: 0, height: 400)
        
        previewingContext.sourceRect = cell.frame
        
        return detailVC
    }
    @IBAction func logOut(_ sender: Any) {
        KeychainWrapper.standard.removeAllKeys()
        try! FIRAuth.auth()?.signOut()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LogViewController") as! LogViewController
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
}
