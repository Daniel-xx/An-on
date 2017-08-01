//
//  LoginVC.swift
//  An•on
//
//  Created by Daniel Travers on 28/07/2017.
//  Copyright © 2017 Daniel Travers. All rights reserved.
//

import UIKit
import Foundation

class LoginVC: UIViewController {
    
    //Text Fields
    @IBOutlet weak var textFieldStack: UIStackView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
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

    }

    @IBAction func emailPickerBtnPressed(_ sender: Any) {
        self.emailField.fadeIn()
        self.passwordField.fadeInDel()
        self.loginPickerStack.setView(view: loginPickerStack, hidden: true)
        self.emailLoginStack.setView(view: emailLoginStack, hidden: false)
    }

    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.emailField.fadeOut()
        self.passwordField.fadeOutDel()
        self.emailField.text = ""
        self.passwordField.text = ""
        self.loginPickerStack.isHidden = false
        self.emailLoginStack.isHidden = true
    }

}

