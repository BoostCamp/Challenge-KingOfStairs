//
//  LogInViewController.swift
//  KingOfStairs
//
//  Created by PACMAN on 2017. 2. 21..
//  Copyright © 2017년 PACMAN. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn

class LogInViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {
    @IBOutlet weak var fbLogIn: UIButton!
    @IBOutlet weak var googleLogIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFacebookButtons()
        
        setupGoogleButton()
    }
    
    fileprivate func setupGoogleButton() {
        // add Google Sign in Button
//        let googleButton = GIDSignInButton()
//        googleButton.frame = CGRect(x: 16, y: view.frame.height - 80 , width: view.frame.width - 32, height: 50)
//        view.addSubview(googleButton)
        
        
//        let customButton = UIButton(type: .system)
//        customButton.frame = CGRect(x: 16, y: 116 + 66 + 66, width: view.frame.width - 32, height: 50)
//        customButton.backgroundColor = .orange
//        view.addSubview(customButton)

        googleLogIn.addTarget(self, action: #selector(handleCustomGoogleSign), for: .touchUpInside)
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    func handleCustomGoogleSign() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    fileprivate func setupFacebookButtons() {
//        let loginButton = FBSDKLoginButton()
//        
//        view.addSubview(loginButton)
//        loginButton.frame = CGRect(x: 16, y: view.frame.height - 140, width: view.frame.width - 32, height: 50)
//        
//        loginButton.delegate = self
//        loginButton.readPermissions = ["email", "public_profile"]
        
//        let customFBButton = UIButton()
//        customFBButton.backgroundColor = .blue
//        customFBButton.frame = CGRect(x: 16, y: 166, width: view.frame.width - 32, height: 50)
//        customFBButton.setTitle("Custom FB Login here", for: .normal)
//        customFBButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        view.addSubview(customFBButton)
        
        fbLogIn.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
    }
    
    func handleCustomFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, error) in
            if error != nil {
                print(error)
                return
            }
            self.showEmailAddress()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        showEmailAddress()
    }
    
    func showEmailAddress() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else { return }
        let credentials = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print(error)
            }
            print(user)
        })
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, error) in
            if error != nil {
                print(error)
                return
            }
            
            print(result)
        }
        
    }
    
}
