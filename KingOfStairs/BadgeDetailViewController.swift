//
//  BadgeDetailViewController.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 22..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import UIKit

class BadgeDetailViewController: UIViewController {

    @IBOutlet weak var badgeImage: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var badge:Badge?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let badge = badge {
            
            badgeImage.image = UIImage(named: badge.name)
            
            if badge.activation {
                captionLabel.text = badge.caption
            } else {
                captionLabel.text = badge.hint
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override var previewActionItems : [UIPreviewActionItem] {
        
        let showOff = UIPreviewAction(title: "친구에게 자랑하기", style: .default) { (action, viewController) -> Void in
            print("친구에게 자랑하기를 선택했습니다.")
        }
        
        let settingMybadge = UIPreviewAction(title: "나의 뱃지로 설정", style: .default) { (action, viewController) -> Void in
            print("나의 뱃지로 설정되었습니다.")
        }
        
        let deleteAction = UIPreviewAction(title: "취소", style: .destructive) { (action, viewController) -> Void in
            print("취소하였습니다.")
        }
        
        return [showOff, settingMybadge, deleteAction]
        
    }

}
