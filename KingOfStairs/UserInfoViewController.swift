//
//  UserInfoViewController.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 21..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import UIKit

class UserInfoViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var heightValue: UITextField!
    @IBOutlet weak var ageValue: UITextField!
    @IBOutlet weak var currentWeight: UITextField!
    @IBOutlet weak var myBasalMetabolism: UILabel!
    @IBOutlet weak var sexValue: UISegmentedControl!
    @IBOutlet weak var pickAnYourLifeStyle: UIPickerView!
    
    let userActivityType = ["운동을 하지 않음", "30 ~ 60분간 꾸준한 운동", "60분 이상의 꾸준한 운동", "60분 이상의 격렬한 운동"]
    var pickedUserActivityType = 1.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UserInfoViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userActivityType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userActivityType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if sexValue.selectedSegmentIndex == 0 {
            if row == 0 {
                self.pickedUserActivityType = 1.00
            } else if row == 1 {
                pickedUserActivityType = 1.11
            } else if row == 2 {
                pickedUserActivityType = 1.25
            } else {
                pickedUserActivityType = 1.48
            }
        } else {
            if row == 0 {
                self.pickedUserActivityType = 1.00
            } else if row == 1 {
                pickedUserActivityType = 1.12
            } else if row == 2 {
                pickedUserActivityType = 1.27
            } else {
                pickedUserActivityType = 1.45
            }
        }
    }
    
    @IBAction func calculateKcl(_ sender: Any) {
        if heightValue.text != "" && ageValue.text != "" && currentWeight.text != ""{
            if let height = heightValue.text, let weight = currentWeight.text, let age = ageValue.text {
                if sexValue.selectedSegmentIndex == 0 {
                    // 미플린 세인트 지어 방식
                    let level1 = 6.25 * Double(height)!
                    let level2 = 10 * Double(weight)!
                    let level3 = 5 * Double(age)!
                    let level4 = level1 + level2 + level3 + 5
                    let level5 = level4 * pickedUserActivityType
                    DataController.sharedInstance().goalKcl = level5 - level4 + 500
                    myBasalMetabolism.text = String(describing: DataController.sharedInstance().goalKcl!)
                } else {
                    let level1 = 6.25 * Double(height)!
                    let level2 = 10 * Double(weight)!
                    let level3 = 5 * Double(age)!
                    let level4 = level1 + level2 + level3 - 161
                    let level5 = level4 * pickedUserActivityType
                    DataController.sharedInstance().goalKcl = level5 - level4 + 500
                    myBasalMetabolism.text = String(describing: DataController.sharedInstance().goalKcl!)
                }
            }
            
        }
        tableView.setContentOffset(CGPoint(x: 0, y: -36), animated: true)
    }
    
    func hideKeyboard() {
        tableView.endEditing(true)
    }
    @IBAction func dismissSetting(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
