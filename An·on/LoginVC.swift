//
//  LoginVC.swift
//  An•on
//
//  Created by Daniel Travers on 28/07/2017.
//  Copyright © 2017 Daniel Travers. All rights reserved.
//

import UIKit
import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class LoginVC: UIViewController, UITextFieldDelegate {
    
    //Text Fields
    @IBOutlet weak var textFieldStack: UIStackView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var largeIcon: UIImageView!
    
    //Login Picker Buttons
    @IBOutlet weak var loginPickerStack: UIStackView!
    @IBOutlet weak var facebookPicker: UIButton!
    @IBOutlet weak var emailPicker: UIButton!
    
    //Email Login Buttons
    @IBOutlet weak var emailLoginStack: UIStackView!
    @IBOutlet weak var cancelbutton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailField.alpha = 0.0
        self.passwordField.alpha = 0.0
        
        //Button Radius is done from DefaultButton class
        self.emailField.delegate = self
        self.passwordField.delegate = self
        
            self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false    }
    
    @IBAction func emailPickerBtnPressed(_ sender: Any) {
        self.emailField.fadeIn()
        self.passwordField.fadeInDel()
        self.largeIcon.dimOut()
        self.loginPickerStack.setView(view: loginPickerStack, hidden: true)
        self.emailLoginStack.setView(view: emailLoginStack, hidden: false)
    }

    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.emailField.fadeOut()
        self.passwordField.fadeOutDel()
        self.largeIcon.dimIn()
        self.emailField.text = ""
        self.emailField.placeholder = "Email Address"
        self.passwordField.text = ""
        self.passwordField.placeholder = "Password"
        self.loginPickerStack.isHidden = false
        self.emailLoginStack.isHidden = true
    }
    
    //FACEBOOK SDK LOGIN KIT
    @IBAction func facebookBtnPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in if error != nil {
            print("DAN: Unable to authenticate with Facebook")
        } else if result?.isCancelled == true {
            print("DAN: User Cancelled")
        } else {
            print("DAN: Success")
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            self.firebaseAuth(credential)
                }
            }
        }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential, completion: { (user, error) in if error != nil {
            print("DAN: Unable to auth")
        } else {
            print("DAN: Authenticated with FIR")
            if let user = user {
                let userData = ["provider": credential.provider]
            self.completeSignIn(id: user.uid, userData: userData)
                }
            }
            })
    }

    //Email Sign In
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if (passwordField.text?.characters.count)! <= 6 {
            passwordField.placeholder = "Must be 6 or more characters"
            passwordField.text = ""
        
        } else {
            
        
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in if error == nil {
                print("DAN: EMAIL USER AUTH WITH FIR")
                if let user = user {
                    let userData = ["provider": user.providerID]
                    self.completeSignIn(id: user.uid, userData: userData) }
            } else {
                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in if error != nil {
                    print("DAN: Unable to auth with fir email")
                    self.emailField.text = ""
                    self.emailField.placeholder = "Invalid Email or"
                    self.passwordField.text = ""
                    self.passwordField.placeholder = "Invalid Password"
                } else {
                    print("DAN: Success created auth email fir")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)}
                }
            })
            }
        })
}
}
}
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("DAN: Saved to keychain")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
}
