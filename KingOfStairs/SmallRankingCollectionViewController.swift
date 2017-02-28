//
//  SmallRankingCollectionViewController.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 27..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RankingCell"

class SmallRankingCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var rankingCollectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankingCollectionView.delegate = self
        rankingCollectionView.dataSource = self
        
        let layout = rankingCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        
        rankingCollectionView.backgroundColor = UIColor(white: 1, alpha: 0.0)
        rankingCollectionView.showsHorizontalScrollIndicator = false
        rankingCollectionView.isHidden = true
        
        
        //collectionView?.register(RankingCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataController.sharedInstance().userData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RankingCollectionViewCell
        
        cell.layer.cornerRadius = cell.frame.size.width / 2
        cell.layer.borderWidth = 1
        
        cell.userImage.image = DataController.sharedInstance().userData[indexPath.row].userImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

