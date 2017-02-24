//
//  LogViewController.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 24..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import Firebase
import GoogleSignIn
import SwiftKeychainWrapper

class LogViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("TS: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("TS: User cancelled Facebook authentificatoin")
            } else {
                print("TS: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("TS: Unalbe to authenticate with Firebase - \(error)")
            } else {
                print("TS: Successfully authenticated with Firebase")
                if let user = user {
                    KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
    
}
